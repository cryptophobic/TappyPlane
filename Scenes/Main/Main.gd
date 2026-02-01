extends Control

@onready var high_score_label: Label = $MC/HighScoreLabel

func _ready() -> void:
	get_tree().paused = false
	high_score_label.text = str(ScoreManager.high_score).lpad(3, "0")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("power"):
		GameManager.load_game_scene()
