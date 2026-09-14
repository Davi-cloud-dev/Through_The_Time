extends CanvasLayer

func _ready():
	await get_tree().create_timer(0.7).timeout
	
	var tween = get_tree().create_tween()

	tween.parallel().tween_property($Label, "modulate:a", 0.0, 1.0)
	tween.parallel().tween_property($ColorRect, "modulate:a", 0.0, 1.0)
	
	await tween.finished
	queue_free()
