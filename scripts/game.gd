extends Node2D

@onready var killzone = $Killzone
@onready var ball = $Ball
@onready var finish_line = $finish_line
var tree_scene_path = "res://scenes/tree.tscn"
@export var tree_scene: PackedScene

@onready var ui = $UI
@onready var progress_bar = ui.get_node("ProgressBar")

var total_distance: float = 0.0
var traveled_distance: float = 0.0

func calc_dist(node_a, node_b):
	if node_a and node_b:
		var position_a = node_a.global_position
		var position_b = node_b.global_position
		return position_a.distance_to(position_b)
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
		var last_pos_x = min_x
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
	total_distance = calc_dist(ball, finish_line)
	spawn_trees()

func _process(_delta):
	traveled_distance = calc_dist(ball, finish_line)
	var progress = traveled_distance / total_distance
	progress_bar.value = progress * 100

