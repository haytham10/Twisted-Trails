extends Area2D

@onready var timer = $Timer

func _ready():
	timer.stop()

func _on_body_entered(body):
	if body.name == "Ball":
		timer.start()
		body.velocity = Vector2.ZERO  # Stop all motion of the ball

func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	
