extends CharacterBody2D

const MAX_SPEED = 180.0
const ACCELERATION = 1  # Controls how quickly the ball accelerates to max speed
const TURN_ANGLE = 0.1  # Adjust for tighter or wider arcs

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.1

# Track the current velocity
var current_velocity_x = 0.0

func _process(delta):
	# Check for input on the left or right side of the screen
	if Input.is_action_just_pressed("move_left"):
		current_velocity_x = -MAX_SPEED
	elif Input.is_action_just_pressed("move_right"):
		current_velocity_x = MAX_SPEED

	# Gradually increase or decrease the speed to the target velocity
	if current_velocity_x < 0:
		current_velocity_x = max(-MAX_SPEED, current_velocity_x - ACCELERATION * delta)
	elif current_velocity_x > 0:
		current_velocity_x = min(MAX_SPEED, current_velocity_x + ACCELERATION * delta)

func _physics_process(delta):
	# Add gravity to the vertical velocity
	if !is_on_floor():
		velocity.y += gravity * delta

	# Calculate the angle of movement for the arc effect
	var angle = current_velocity_x * TURN_ANGLE * delta

	# Update the horizontal velocity to create a smooth arc
	velocity.x = current_velocity_x * cos(angle)
	velocity.y += current_velocity_x * sin(angle)

	# Move the character
	move_and_slide()
