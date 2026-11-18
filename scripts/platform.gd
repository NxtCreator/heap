extends AnimatableBody2D
const FALL_SPEED := 100
var is_falling = true


func _ready() -> void:
	$Polygon2D.color = Palette.MID

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_falling:
		var collision = move_and_collide(Vector2(0, FALL_SPEED * delta))
		
		if collision != null:
			is_falling = false
			set_collision_layer_value(3, false)
			set_collision_layer_value(1, true)
			
			
			for body in $Hurtbox.get_overlapping_bodies():
				body.die()
