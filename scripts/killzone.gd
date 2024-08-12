extends Area2D

@onready var timer = $Timer

func _ready():
	timer.stop()

func _on_body_entered(body):
	if body.name == "Ball":
		# Trigger the death animation
		body.play_death_animation()
		timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
