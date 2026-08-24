extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var stand_collision = $CollisionStand  # Arraste ou ajuste o nome do seu CollisionShape em pé
@onready var crouch_collision = $CollisionCrouch # Arraste ou ajuste o nome do seu CollisionShape agachado

const JUMP_VELOCITY = -250.0

var is_crouching := false

func _ready():
	add_to_group("Player")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor() and not is_crouching:
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("Crouch") and is_on_floor():
		is_crouching = true
	else:
		is_crouching = false

	stand_collision.disabled = is_crouching
	crouch_collision.disabled = not is_crouching

	if not is_on_floor():
		anim.play("Jump")
	elif is_crouching:
		anim.play("Crouch")
	else:
		anim.play("Run")

	move_and_slide()
