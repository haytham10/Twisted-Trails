extends Camera2D

@export var offset_start: float = 300.0
@export var offset_end: float = 0.0
@export var transition_duration: float = 4.0  # Time in seconds to complete the transition

var transition_time: float = 0.0
var transitioning: bool = false

func _ready():
	# Set the initial offset
	offset.y = offset_start
	# Start transitioning on level start
	transition_time = 0.0
	transitioning = true

func _process(delta):
	if transitioning:
		# Calculate the transition progress
		transition_time += delta
		var t = clamp(transition_time / transition_duration, 0.0, 1.0)
		
		# Smoothly interpolate the y offset
		offset.y = lerp(offset_start, offset_end, t)
		
		# Check if the transition is complete
		if t >= 1.0:
			transitioning = false

func reset_offset():
	# Reset the offset for level restart
	offset.y = offset_start
	transition_time = 0.0
	transitioning = true