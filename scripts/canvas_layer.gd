extends CanvasLayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
		
	$ScoreLabel.text = str(player.best_height)
	$GameOverLabel.visible = player.is_dead
	
	if player.is_dead and Input.is_action_just_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()
