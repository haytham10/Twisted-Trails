extends CharacterBody2D

@export var max_speed: float = 200.0  # Maximum speed of the ball
@export var rotation_speed: float = 1.2  # Speed of rotation
@export var gravity: float = 200.0  # Downward force to simulate gravity

var velocity_x: float = 0.0
var moving_left: bool = false
var moving_right: bool = false

func _ready():
	# Initialize the downward velocity to start rolling immediately
	velocity.y = gravity

func _process(_delta):
	# Toggle direction on key press
	if Input.is_action_just_pressed("ui_left"):
		moving_left = true
		moving_right = false  # Reset other direction
	elif Input.is_action_just_pressed("ui_right"):
		moving_right = true
		moving_left = false  # Reset other direction

func _physics_process(_delta):
	# Set target velocity based on direction
	if moving_left:
		velocity_x = -max_speed
	elif moving_right:
		velocity_x = max_speed

	# Apply horizontal velocity
	velocity.x = velocity_x

	# Apply gravity for vertical drop
	velocity.y = gravity

	# Move the ball
	move_and_slide()
