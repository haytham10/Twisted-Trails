extends Node2D

@export var ground_scene: PackedScene = preload("res://scenes/ground.tscn")  # PackedScene for the ground segment
@export var segment_height: float = 200.0  # The height of each ground segment
@export var max_segments: int = 10  # Maximum number of segments to keep in memory

var ground_segments = []

func _ready():
	# Initial generation of ground segments
	for i in range(max_segments):
		create_ground_segment(i * -segment_height)

func _process(delta):
	# Continuously check and manage ground segments
	manage_ground_segments()

func create_ground_segment(y_position: float):
	# Instantiate and position the ground segment
	var ground_instance = ground_scene.instantiate()
	ground_instance.position = Vector2(0, y_position)
	add_child(ground_instance)
	ground_segments.append(ground_instance)

func manage_ground_segments():
	var ball_node = get_node("/root/Game/Ball")  # Use the correct path to the Ball node
	var ball_position_y = ball_node.global_position.y

	# Remove segments behind the player
	while ground_segments.size() > 0 and ground_segments.front().position.y > ball_position_y + segment_height:
		var old_segment = ground_segments.pop_front()
		old_segment.call_deferred("queue_free")

	# Add new segments ahead of the player
	while ground_segments.size() < max_segments:
		var last_segment = ground_segments.back()
		create_ground_segment(last_segment.position.y - segment_height)
