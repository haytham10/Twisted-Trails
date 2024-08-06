extends Node2D

@onready var killzone = $Killzone
@onready var ball = $Ball
@onready var finish_line = $finish_line

func calc_dist(node_a, node_b):
	if node_a and node_b:
		var position_a = node_a.global_position
		var position_b = node_b.global_position
		return position_a.distance_to(position_b)
	return -1  # Return -1 if either node is null

func _ready():
	var distance = calc_dist(ball, finish_line)
	#if distance != -1:
		#print("Initial distance: ", distance)

func _process(_delta):
	var distance = calc_dist(ball, finish_line)
	#if distance != -1:
		#print(distance)
