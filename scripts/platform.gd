extends AnimatableBody2D
const FALL_SPEED := 100
var is_falling = true


func set_size(w, h):
	$CollisionShape2D.shape.size = Vector2(w, h)
	$Hurtbox/CollisionShape2D.shape.size = Vector2(w, h)
	var half_w = w / 2.0
	var half_h = h / 2.0
	$Polygon2D.polygon = PackedVector2Array([
		Vector2(-half_w, -half_h),
		Vector2(half_w, -half_h),
		Vector2(half_w, half_h),
		Vector2(-half_w, half_h)
	])

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
