extends Area2D
@export var speed := 300.0

func _process(delta):
	# Move o inimigo para a esquerda
	position.x -= speed * delta

# Sinal ligado ao VisibleOnScreenNotifier2D
func _on_visible_on_screen_notifier_2d_screen_exited():
	# Deleta o inimigo da memória quando ele sai da tela pela esquerda
	queue_free()

# Sinal ligado ao próprio Area2D (body_entered)
func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("GAME OVER! Voltando para a primeira fase...")
		
		# 1. Reseta o score global (caso você use o singleton Global)
		if typeof(Global) != TYPE_NIL and "score" in Global:
			Global.score = 0.0
		
		# 2. Carrega a Primeira Fase (Coloque o caminho correto da sua Fase 1 ou Main.tscn)
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
