extends Node2D
const PLATFORM = preload("res://scenes/platform.tscn")
const MIN_X = 426
const MAX_X = 726



func _on_timer_timeout() -> void:
	var platform = PLATFORM.instantiate()
	var block_sizes = [32, 64, 96, 128, 160]
	var block_size = block_sizes.pick_random()
	add_child(platform)
	platform.set_size(block_size, 32)
	platform.global_position = Vector2(randf_range(MIN_X, MAX_X), -100)
	
