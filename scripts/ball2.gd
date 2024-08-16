extends CharacterBody2D

@export var max_speed: float = 270.0
@export var gravity: float = 270.0
@onready var animation_player = $AnimationPlayer

var has_moved: bool = false
var stopped: bool = false

func _ready():
	velocity.y = gravity

func _process(_delta):
	if stopped:
		return
	
	# Check if the ball has started moving
	if not has_moved and Input.is_mouse_button_pressed(1):
		has_moved = true
		var camera = $Camera2D
		if camera:
			camera.start_transition()

	# If the ball has started moving, follow the cursor
	if has_moved:
		var target_x = get_global_mouse_position().x
		var distance_x = target_x - global_position.x

		# Smoothly move towards the cursor
		if abs(distance_x) > 0.1:
			velocity.x = clamp(distance_x * 10, -max_speed, max_speed)
		else:
			velocity.x = 0

func _physics_process(_delta):
	if stopped:
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	if has_moved:
		velocity.y = gravity
		move_and_slide()

func play_death_animation():
	stopped = true
	velocity = Vector2.ZERO  # Stop the ball's movement
	animation_player.play("Death")
	animation_player.connect("animation_finished", Callable(self, "_on_death_animation_finished"))

func _on_death_animation_finished(anim_name: String):
	if anim_name == "Death":
		get_tree().reload_current_scene()

func stop_ball():
	stopped = true
