extends Node2D
const PLATFORM = preload("res://scenes/platform.tscn")
const MIN_X = 426
const MAX_X = 726



func _on_timer_timeout() -> void:
	var platform = PLATFORM.instantiate()
	add_child(platform)
	platform.global_position = Vector2(randf_range(MIN_X, MAX_X), -100)
	
