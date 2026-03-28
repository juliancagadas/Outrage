extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -380.0

@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Movement
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
	# Animation Logic
	
	if not is_on_floor():
		anim.play("jump")
		
	elif direction != 0:
		anim.play("run")
	
	else:
		anim.play("idle")
	
	
