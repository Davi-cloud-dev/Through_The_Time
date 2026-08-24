extends ParallaxBackground

@export var start_speed := 200.0
@export var target_score := 1000.0 
@export var next_scene : PackedScene
@export var score_label : Label

var acceleration := 10.0
var current_speed := start_speed

func _process(delta):
	current_speed += acceleration * delta
	scroll_offset.x -= current_speed * delta
	
	Global.score += delta * 100.0
	
	if score_label != null:
		score_label.text = "Score: " + str(int(Global.score))
	
	if Global.score >= target_score:
		change_level()

func change_level():
	if next_scene != null:
		get_tree().change_scene_to_packed(next_scene)
	else:
		print("AVISO: Nenhuma próxima cena atribuída no Inspector!")
