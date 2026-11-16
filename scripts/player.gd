extends CharacterBody2D

const GRAVITY = 500
const SPEED = 300
const JUMP_SPEED = 200



func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_up"):
		velocity.y = JUMP_SPEED
		
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
		
	velocity.y += GRAVITY * delta
	move_and_slide()
