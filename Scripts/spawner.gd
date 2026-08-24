extends Node2D

@export var ground_enemy_scene : PackedScene
@export var air_enemy_scene : PackedScene

@export var ground_marker : Marker2D
@export var air_marker : Marker2D

@onready var timer = $Timer

func _ready():
	print("--- INICIANDO SPAWNER ---")
	print("Ground Scene: ", ground_enemy_scene)
	print("Air Scene: ", air_enemy_scene)
	print("Ground Marker: ", ground_marker)
	print("Air Marker: ", air_marker)
	
	if not timer:
		print("ERRO CRÍTICO: O nó Timer não foi encontrado!")
	else:
		timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	print("Timer disparou!")
	spawn_enemy()

func spawn_enemy():
	var enemy_type = randi() % 2
	print("Tentando spawnar tipo: ", enemy_type)
	
	var new_enemy : Area2D = null
	var target_marker : Marker2D = null

	if enemy_type == 0:
		if ground_enemy_scene and ground_marker:
			new_enemy = ground_enemy_scene.instantiate()
			target_marker = ground_marker
		else:
			print("FALHA: Faltou ground_enemy_scene ou ground_marker!")
	else:
		if air_enemy_scene and air_marker:
			new_enemy = air_enemy_scene.instantiate()
			target_marker = air_marker
		else:
			print("FALHA: Faltou air_enemy_scene ou air_marker!")

	if new_enemy and target_marker:
		new_enemy.global_position = target_marker.global_position
		get_parent().add_child(new_enemy)
		print("SUCESSO: Inimigo criado na posição ", target_marker.global_position)
