extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -200.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	var running = Input.is_action_pressed("run")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		elif velocity.x == 150 or velocity.x == -150:
			animated_sprite.play("walking")
		else:
			animated_sprite.play("running")
			
		
	else:
		animated_sprite.play("jumping")

	
	if direction:
		if running:
			velocity.x = direction * (SPEED * 1.4)
			
		else: 
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
