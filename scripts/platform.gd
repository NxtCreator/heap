extends AnimatableBody2D
const FALL_SPEED := 100
var is_falling = true


func set_width(w):
	$CollisionShape2D.shape.size = Vector2(w, 32)
	$Hurtbox/CollisionShape2D.shape.size = Vector2(w, 32)

func _ready() -> void:
	$Polygon2D.color = Palette.MID
	set_width(64)

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
