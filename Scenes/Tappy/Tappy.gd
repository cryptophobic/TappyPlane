extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var _gravity: float = ProjectSettings.get("physics/2d/default_gravity")

var _jumped: bool = false
const JUMP_POWER = -350.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("power"):
		_jumped = true
		
func die() -> void:
	set_physics_process(false)
	animated_sprite_2d.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta
	if _jumped:
		velocity.y = JUMP_POWER
		_jumped = false
		
	move_and_slide()
	
	if is_on_floor():
		die()
