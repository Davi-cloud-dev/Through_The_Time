extends Node

var score := 0.0
var score_inicial_fase := 0.0

# Cria o reprodutor de áudio por código e carrega o arquivo
var death_player := AudioStreamPlayer.new()
var death_sound = preload("res://Audios/audiomorrergodot.mp3") # Troque pelo caminho exato do seu som!

func _ready():
	# Adiciona o reprodutor na árvore do jogo assim que ele inicia
	add_child(death_player)
	death_player.stream = death_sound

func play_death_sound():
	death_player.play()

# Chama isso quando entra numa fase nova
func salvar_checkpoint_fase():
	score_inicial_fase = score

# Chama isso quando o jogador morre na mesma fase
func reiniciar_pontuacao_fase():
	score = score_inicial_fase
