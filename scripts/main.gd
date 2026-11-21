extends Node2D
const PLATFORM = preload("res://scenes/platform.tscn")
const ENEMY = preload("res://scenes/enemy.tscn")
const MIN_X = 426
const MAX_X = 726
var highest_platform_edge = 584.0
const CAMERA_LINE_Y = 324.0
var camera_target_y = min(324.0, highest_platform_edge + 324.0 - CAMERA_LINE_Y)

const BLOCK_SHAPES = [
	Vector2(32, 32), Vector2(64, 32), Vector2(64, 32),
	Vector2(96, 32), Vector2(96, 32), Vector2(128, 32),
	Vector2(160, 32), Vector2(32, 64), Vector2(32, 96),
]
var bag = []

func next_block_size():
	if bag.is_empty():
		bag = BLOCK_SHAPES.duplicate()
		bag.shuffle()
	return bag.pop_back()

func _on_platform_landed(top_y):
	highest_platform_edge = min(highest_platform_edge, top_y)
	camera_target_y = min(324.0, highest_platform_edge + 324.0 - CAMERA_LINE_Y)
	
func _on_timer_timeout() -> void:
	var platform = PLATFORM.instantiate()
	add_child(platform)
	var size = next_block_size()
	platform.set_size(size.x, size.y)
	platform.global_position = Vector2(randf_range(MIN_X, MAX_X), $Camera2D.position.y - 424)
	platform.landed.connect(_on_platform_landed)
	
func _process(_delta: float) -> void:
	$Camera2D.position.y = lerp($Camera2D.position.y, camera_target_y, 0.5)
		
		
# Shelved for now
#func _on_enemy_timer_timeout() -> void:
	#if get_tree().get_first_node_in_group("enemies") == null:
		#var enemy = ENEMY.instantiate()
		#$Camera2D.add_child(enemy)
		#enemy.position = Vector2(randf_range(-300, 300), -250)
