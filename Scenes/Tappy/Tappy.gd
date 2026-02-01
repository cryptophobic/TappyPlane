extends CharacterBody2D

class_name Tappy

#signal on_plane_died

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _gravity: float = ProjectSettings.get("physics/2d/default_gravity")

var score: int = 0

var _jumped: bool = false
const JUMP_POWER = -350.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("power"):
		_jumped = true
		
func fly(delta: float) -> void:
	velocity.y += _gravity * delta
	if _jumped:
		velocity.y = JUMP_POWER
		_jumped = false
		animation_player.play("thrust")

		
func die() -> void:
	SignalHub.emit_on_plane_died()
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	fly(delta)
	move_and_slide()
	
	if is_on_floor():
		die()
		
