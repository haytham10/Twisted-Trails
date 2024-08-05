extends CharacterBody2D

@export var max_speed: float = 100.0  # Maximum speed of the ball
@export var rotation_speed: float = 1.0  # Speed of rotation
@export var gravity: float = 300.0  # Downward force to simulate gravity

var velocity_x: float = 0.0
var moving_left: bool = false

func _ready():
	# Start with a constant downward velocity
	velocity.y = gravity

func _process(delta):
	# Toggle direction on key press
	if Input.is_action_just_pressed("ui_left"):
		moving_left = true
	elif Input.is_action_just_pressed("ui_right"):
		moving_left = false

	# Set target velocity based on direction
	if moving_left:
		velocity_x = -max_speed
	else:
		velocity_x = max_speed

	# Calculate the angle for smooth turning
	var angle_direction = -1 if moving_left else 1
	rotation += angle_direction * rotation_speed * delta

func _physics_process(delta):
	# Apply horizontal velocity
	velocity.x = velocity_x

	# Apply gravity for vertical drop
	velocity.y = gravity

	# Move the ball
	move_and_slide()

	# Adjust position based on velocity to simulate turning
	var forward_movement = Vector2(-sin(rotation), cos(rotation)) * velocity.y * delta
	global_position += forward_movement
