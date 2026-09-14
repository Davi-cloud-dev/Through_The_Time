extends ParallaxBackground

@export var start_speed := 200.0
@export var target_score := 1000.0  # Pontuação necessária para mudar de fase
@export var next_scene : PackedScene  # Próxima fase
@export var score_label : Label  # Label da pontuação
@export var is_final_level := false  # Marque na última fase
@export var end_screen : CanvasLayer  # Tela mostrada quando o jogo termina

var acceleration := 10.0
var current_speed := start_speed
var level_finished := false

func _ready():
	if is_final_level and end_screen != null:
		end_screen.visible = false
		var restart_button = end_screen.get_node_or_null("Panel/RestartButton")
		var quit_button = end_screen.get_node_or_null("Panel/QuitButton")
		if restart_button != null:
			restart_button.pressed.connect(_restart_game)
		if quit_button != null:
			quit_button.pressed.connect(_quit_game)

func _process(delta):
	if level_finished:
		return

	# 1. Movimentação e aceleração do fundo
	current_speed += acceleration * delta
	scroll_offset.x -= current_speed * delta

	# 2. Soma o score no Autoload Global
	Global.score += delta * 100.0

	# 3. Atualiza o texto na tela se o Label estiver configurado
	if score_label != null:
		score_label.text = "Score: " + str(int(Global.score))

	# 4. Verifica se alcançou o objetivo da fase
	if Global.score >= target_score:
		if next_scene != null:
			level_finished = true
			get_tree().change_scene_to_packed(next_scene)
		elif is_final_level:
			finish_game()
		else:
			# Evita imprimir o aviso a cada frame caso uma fase fique sem próxima cena.
			level_finished = true
			print("AVISO: Nenhuma próxima cena atribuída no Inspector!")

func finish_game():
	level_finished = true

	# Mostra a tela final ainda dentro da fase futurista.
	if end_screen != null:
		var final_score = end_screen.get_node_or_null("Panel/FinalScore")
		if final_score != null:
			final_score.text = "Pontuação final: " + str(int(Global.score))
		end_screen.visible = true

	# Congela a corrida no momento em que a viagem termina.
	get_tree().paused = true

func _restart_game():
	get_tree().paused = false
	Global.score = 0.0
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _quit_game():
	get_tree().paused = false
	get_tree().quit()
