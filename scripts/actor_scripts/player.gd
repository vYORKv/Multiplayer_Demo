extends CharacterBody2D

const BLUE_PLAYER: Object = preload("res://assets/actors/blue_player.png")
const RED_PLAYER: Object = preload("res://assets/actors/red_player.png")

const ACCELERATION: int = 200#2000
const FRICTION: int = 400#4000
const TURN_SPEED: float = 0.15

var speed: int = 100#300
var input_allowed: bool = true

func _ready() -> void:
	if Global.color == "red":
		$Sprite2D.set_texture(RED_PLAYER)
	elif Global.color == "blue":
		$Sprite2D.set_texture(BLUE_PLAYER)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		NetworkController.KillNetwork()
		await get_tree().create_timer(.5).timeout

func _physics_process(delta: float) -> void:
	if input_allowed:
		Movement(delta)

func Movement(delta: float) -> void:
	#var mouse_position: Vector2 = get_global_mouse_position()
	# Literal movement
	var input_vector: Vector2 = Vector2.ZERO
	LookAtMouse()
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * speed, ACCELERATION * delta)
		#if speed == 100:
			#MakeNoise("low")
			#PlayFootstep(FOOTSTEP_LOUD, "loud")
		#elif speed == 50:
			#PlayFootstep(FOOTSTEP_QUIET, "quiet")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		#FootstepSFX.stop()
	move_and_slide()

func LookAtMouse() -> void:
	var v: Vector2 = get_global_mouse_position() - self.global_position
	var angle: float = v.angle()
	var r: float = global_rotation
	global_rotation = lerp_angle(r, angle, TURN_SPEED)
