extends Node2D

@onready var killzone = $Killzone
@onready var ball = $Ball
@onready var finish_line = $finish_line
@onready var progress_bar = $UI/ProgressBar
@onready var distance_label = progress_bar.get_node("Label")  # Adjust the path to your label node

var initial_distance: float = 0.0
var tree_scene_path = "res://scenes/tree.tscn"
@export var tree_scene: PackedScene

func calc_dist(node_a, node_b):
	if node_a and node_b:
		var position_a = node_a.global_position
		var position_b = node_b.global_position
		var distance = position_a.distance_to(position_b)
		if distance <= 5.0:  # Threshold to consider reaching the finish line
			return 0.0
		return round(distance)
	return -1  # Return -1 if either node is null

# Variables for tree generation
func spawn_trees():
	# Instance a new tree from the scene
	if tree_scene == null:
		tree_scene = load(tree_scene_path)  # Load the scene at runtime
	var min_x = -130 # Minimum x position for tree spawn
	var max_x = 180 # Maximum x position for tree spawn
	var min_y = ball.global_position.y  # Minimum y position for tree spawn
	var max_y = finish_line.global_position.y - 300
	while (min_y < max_y - 100):
		# Set the tree's position randomly within the specified x and y range
		var i = 0
		var trees_per_line = randi_range(2, 5)
		var tree_positions = []
		while (i < trees_per_line):
			var tree = tree_scene.instantiate()
			
			# Set random position
			var pos_x = randf_range(min_x, max_x)
			tree.position = Vector2(pos_x, min_y)
			
			var random_scale = randf_range(0.55, 0.85)
			tree.scale = Vector2(random_scale, random_scale)
			
			# Adjust the size of the CollisionShape2D based on the new scale
			var collision_shape = tree.get_node("CollisionShape2D")
			if collision_shape and collision_shape.shape is RectangleShape2D:
				collision_shape.shape.extents *= random_scale
				
			tree_positions.append(pos_x)
			i += 1
			add_child(tree)
		# Add the tree to the current scene
		min_y += 75

func _ready():
	initial_distance = calc_dist(ball, finish_line)
	distance_label.text = str(0)
	#spawn_trees()

func _process(_delta):
	if initial_distance <= 0:
		return
	
	var current_distance = calc_dist(ball, finish_line)
	
	var progress = clamp(1.0 - (current_distance / initial_distance), 0.0, 1.0) * 100.0

	if (progress_bar.value < 97):
		progress_bar.value = progress
	else:
		progress_bar.value = 100
	
		
	var distance = initial_distance - current_distance;
	
	if (distance > 0):
		distance_label.text = str(round(distance))
