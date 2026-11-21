extends CanvasLayer

const SAVE_PATH := "user://heap.cfg"
var high_score := 0

func  _ready() -> void:
	var cfg = ConfigFile.new()
	if cfg.load(SAVE_PATH) == OK:
		high_score = cfg.get_value("score", "best", 0)
		
func save_high_score() -> void:
	var cfg = ConfigFile.new()
	cfg.set_value("score", "best", high_score)
	cfg.save(SAVE_PATH)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
		
	if Input.is_action_just_pressed("pause") and not player.is_dead:
		get_tree().paused = not get_tree().paused
	$PauseLabel.visible = get_tree().paused and not player.is_dead
	
	$ScoreLabel.text = str(player.best_height)
	$GameOverLabel.visible = player.is_dead
	$HighScoreLabel.text = "Best " + str(high_score)
	
	if player.is_dead  and player.best_height > high_score:
		high_score = player.best_height
		save_high_score()
	
	if player.is_dead and Input.is_action_just_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()
