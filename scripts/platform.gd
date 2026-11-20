extends AnimatableBody2D
const FALL_SPEED := 100
var is_falling = true
var platform_h = 32
var platform_w = 128

signal landed(top_y)


func set_size(w, h):
	platform_h = h
	platform_w  = w
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
	queue_redraw()
	
func _draw() -> void:
	var cols = int(platform_w / 32.0)
	var rows = int(platform_h / 32.0)
	var top_left = Vector2(-platform_w / 2.0, -platform_h / 2.0)
	for col in range(cols):
		for row in range(rows):
			var cell_pos = top_left + Vector2(col * 32, row * 32)
			draw_rect(Rect2(cell_pos, Vector2(32, 32)), Palette.FG, false, 2)

func _ready() -> void:
	$Polygon2D.color = Palette.DARK

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_falling:
		var collision = move_and_collide(Vector2(0, FALL_SPEED * delta))
		
		if collision != null:
			is_falling = false
			set_collision_layer_value(3, false)
			set_collision_layer_value(1, true)
			landed.emit(global_position.y - platform_h / 2.0)
			
			
			for body in $Hurtbox.get_overlapping_bodies():
				body.die()
