extends Node

signal on_plane_died
signal on_point_scored
signal on_speed_increase

func emit_on_plane_died() -> void:
	on_plane_died.emit()

func emit_on_point_scored() -> void:
	on_point_scored.emit()

func emit_on_speed_increase() -> void:
	on_speed_increase.emit()
