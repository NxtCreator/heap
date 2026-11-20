extends Area2D

func _ready() -> void:
	$Body.color = Palette.ACCENT
	$Barrel.color = Palette.ACCENT
	add_to_group("enemies")
	
func _process(_delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		look_at(player.global_position)
	else: return
	
