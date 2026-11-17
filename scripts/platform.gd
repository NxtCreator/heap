extends AnimatableBody2D
const FALL_SPEED := 100
var is_falling = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_falling:
		var collision = move_and_collide(Vector2(0, FALL_SPEED * delta))
		
		if collision != null:
			is_falling = false
			
			for body in $Hurtbox.get_overlapping_bodies():
				body.die()
