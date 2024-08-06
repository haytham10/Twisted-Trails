extends CharacterBody2D

@export var max_speed: float = 200.0  # Maximum speed of the ball
@export var rotation_speed: float = 0.5  # Speed of rotation
@export var gravity: float = 200.0  # Downward force to simulate gravity

var moving_left: bool = false
var moving_right: bool = false
var started: bool = false  # Track if the ball has started moving

func _ready():
	# Initialize the velocity to zero to keep the ball stationary
	velocity = Vector2.ZERO

func _process(_delta):
	# Toggle direction on key press and start the ball
	if Input.is_action_just_pressed("ui_left"):
		moving_left = true
		moving_right = false
		started = true
	elif Input.is_action_just_pressed("ui_right"):
		moving_right = true
		moving_left = false
		started = true

func _physics_process(_delta):
	# Only apply gravity and movement if the ball has started
	if started:
		# Set target velocity based on direction
		if moving_left:
			velocity.x = -max_speed
		elif moving_right:
			velocity.x = max_speed
		else:
			velocity.x = 0

		# Apply gravity for vertical drop
		velocity.y = gravity

	# Move the ball
	move_and_slide()