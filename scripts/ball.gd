extends CharacterBody2D

const SPEED = 180.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.6

# Track the current horizontal direction
var moving_left = true

func _process(delta):
	# Check for input on the left or right side of the screen
	if Input.is_action_just_pressed("move_left"):
		moving_left = true
	elif Input.is_action_just_pressed("move_right"):
		moving_left = false

func _physics_process(delta):
	# Add gravity to the vertical velocity
	if !is_on_floor():
		velocity.y += gravity * delta

	# Set horizontal velocity based on the current direction
	if moving_left:
		velocity.x = -SPEED
	else:
		velocity.x = SPEED

	# Move the character
	move_and_slide()
