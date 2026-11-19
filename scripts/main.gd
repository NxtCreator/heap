extends Node2D
const PLATFORM = preload("res://scenes/platform.tscn")
const MIN_X = 426
const MAX_X = 726



func _on_timer_timeout() -> void:
	var platform = PLATFORM.instantiate()
	var block_sizes = [32, 64, 96, 128, 160]
	var length = block_sizes.pick_random()
	add_child(platform)
	if randf() < 0.5:
		platform.set_size(length, 32)
	else:
		platform.set_size(32, length)
	platform.global_position = Vector2(randf_range(MIN_X, MAX_X), -100)
	
