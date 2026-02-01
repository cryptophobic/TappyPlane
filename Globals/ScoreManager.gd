extends Node

const SCORES_PATH: String = "user://tappyscore.tres"

var high_score: int = 0:
	get:
		return high_score
	set(value):
		if value > high_score:
			high_score = value
			save_high_score()
			
			
func _ready() -> void:
	load_high_score()
		

func save_high_score() -> void:
	var hsr: HighScoreResource = HighScoreResource.new()
	hsr.high_score = high_score
	ResourceSaver.save(hsr, SCORES_PATH)
	
func load_high_score() -> void:
	high_score = 0
	if !ResourceLoader.exists(SCORES_PATH):
		return
		
	var hsr: HighScoreResource = ResourceLoader.load(SCORES_PATH)
	if hsr:
		high_score = hsr.high_score
