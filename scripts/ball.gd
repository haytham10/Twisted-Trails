extends CharacterBody2D

@export var max_speed: float = 200.0
@export var gravity: float = 200.0
@onready var animation_player = $AnimationPlayer

var moving_left: bool = false
var moving_right: bool = false
var has_moved: bool = false
var stopped: bool = false

func _ready():
	velocity.y = gravity

func _process(_delta):
	if stopped:
		return
	
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		if not has_moved:
			has_moved = true
			# Use the direct child reference to find the camera
			var camera = $Camera2D
			if camera:
				camera.start_transition()

		moving_left = Input.is_action_just_pressed("ui_left")
		moving_right = Input.is_action_just_pressed("ui_right")

func _physics_process(_delta):
	if stopped:
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	if has_moved:
		if moving_left:
			velocity.x = -max_speed
		elif moving_right:
			velocity.x = max_speed
		else:
			velocity.x = 0

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
