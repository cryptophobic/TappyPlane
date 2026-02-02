extends Control

class_name GameUI

@onready var game_over_label: Label = $MarginContainer/GameOverLabel
@onready var press_space_label: Label = $MarginContainer/PressSpaceLabel
@onready var game_over: Timer = $GameOver
@onready var sound: AudioStreamPlayer = $Sound
@onready var score_label: Label = $MarginContainer/ScoreLabel

var _points: int = 0


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		GameManager.load_main_scene()
		
	if press_space_label.visible and event.is_action_pressed("power"):
		_points = 0
		on_point_scored()
		GameManager.load_main_scene()
		

func _ready() -> void:
	SignalHub.on_plane_died.connect(on_plane_died) 
	SignalHub.on_point_scored.connect(on_point_scored)
	game_over.timeout.connect(_on_game_over_timeout)
	
func update_score_label() -> void:
	score_label.text = str(_points).lpad(3, "0")
	
func on_point_scored() -> void:
	_points += 1
	ScoreManager.score = _points
	if _points % 10 == 0:
		SignalHub.emit_on_speed_increase()
	update_score_label()

func on_plane_died() -> void:
	game_over_label.show()
	sound.play()
	game_over.start()
	ScoreManager.high_score = _points

func _on_game_over_timeout() -> void:
	game_over_label.hide()
	press_space_label.show()
