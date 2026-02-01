extends Control

const GAME = preload("res://Scenes/Game/Game.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("power"):
		get_tree().change_scene_to_packed(GAME)
