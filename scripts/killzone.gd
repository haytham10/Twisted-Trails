extends Area2D

@onready var timer = $Timer

func _ready():
	timer.stop()

func _on_body_entered(body):
	if body.name == "Ball":
		timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
	
