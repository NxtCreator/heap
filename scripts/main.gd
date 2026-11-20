extends Node2D
const PLATFORM = preload("res://scenes/platform.tscn")
const ENEMY = preload("res://scenes/enemy.tscn")
const MIN_X = 426
const MAX_X = 726
var highest_platform_edge = 584.0
const CAMERA_LINE_Y = 324.0
var camera_target_y = min(324.0, highest_platform_edge + 324.0 - CAMERA_LINE_Y)

func _on_platform_landed(top_y):
	highest_platform_edge = min(highest_platform_edge, top_y)
	camera_target_y = min(324.0, highest_platform_edge + 324.0 - CAMERA_LINE_Y)
	
func _on_timer_timeout() -> void:
	var platform = PLATFORM.instantiate()
	var block_sizes = [32, 64, 96, 128, 160]
	var length = block_sizes.pick_random()
	add_child(platform)
	if randf() < 0.5:
		platform.set_size(length, 32)
	else:
		platform.set_size(32, length)
	platform.global_position = Vector2(randf_range(MIN_X, MAX_X), $Camera2D.position.y - 424)
	platform.landed.connect(_on_platform_landed)
	
func _process(_delta: float) -> void:
	$Camera2D.position.y = lerp($Camera2D.position.y, camera_target_y, 0.5)
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
		
	$CanvasLayer/ScoreLabel.text = str(player.best_height)
		
# Shelved for now
#func _on_enemy_timer_timeout() -> void:
	#if get_tree().get_first_node_in_group("enemies") == null:
		#var enemy = ENEMY.instantiate()
		#$Camera2D.add_child(enemy)
		#enemy.position = Vector2(randf_range(-300, 300), -250)
