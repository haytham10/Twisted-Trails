extends Line2D

@export var trail_length: int = 300  # Maximum number of points in the trail
@export var trail_width: float = 8.0  # Width of the trail
@export var ball_color: Color = Color(0.2, 0.7, 0.9)  # Color of the trail

func _ready():
	width = trail_width
	default_color = ball_color
	
	set_round_precision(100)
	
	# Clear any existing points
	clear_points()

func _process(_delta):
	# Get the current position of the ball's parent node (i.e., the ball)
	var ball_position = get_parent().global_position
	
	# Add the current position to the points of the Line2D
	add_point(ball_position)
	set_round_precision(100)
	
	
	# Keep only the last 'trail_length' points
	if points.size() > trail_length:
		remove_point(0)
	
	# Update the Line2D's position to match the ball's position
	global_position = Vector2.ZERO  # Ensures the Line2D is always relative to the ball
