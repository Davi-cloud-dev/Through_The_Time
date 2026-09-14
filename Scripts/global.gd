extends Node

var score := 0.0
var score_inicial_fase := 0.0

# Chama isso quando entra numa fase nova
func salvar_checkpoint_fase():
	score_inicial_fase = score

# Chama isso quando o jogador morre na mesma fase
func reiniciar_pontuacao_fase():
	score = score_inicial_fase
