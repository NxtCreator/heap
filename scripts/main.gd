extends Node2D
const PLATFORM = preload("res://scenes/platform.tscn")



func _on_timer_timeout() -> void:
	var platform = PLATFORM.instantiate()
	add_child(platform)
	platform.global_position = Vector2(576, -100)
	
