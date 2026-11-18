extends CharacterBody2D

const GRAVITY = 1200
const SPEED = 300
const JUMP_SPEED = -500
var is_dead = false
const DEATH_PUFF = preload("res://scenes/death_puff.tscn")



func die():
	if is_dead:
		return
	is_dead = true
	var death_puff = DEATH_PUFF.instantiate()
	death_puff.emitting = true
	get_parent().add_child(death_puff)
	death_puff.global_position = global_position

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_SPEED
		
		
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
		
	velocity.y += GRAVITY * delta
	move_and_slide()
	
	if is_on_floor() and is_on_ceiling():
		die()
