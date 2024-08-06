extends Area2D

func _on_body_exited(body):
	if body.name == "Ball":
		body.stop_ball()
		print("Finish line reached!")

