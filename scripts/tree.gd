extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	if body.name == "Ball":
		timer.start()
		body.play_death_animation()

func _on_timer_timeout():
	get_tree().reload_current_scene()
