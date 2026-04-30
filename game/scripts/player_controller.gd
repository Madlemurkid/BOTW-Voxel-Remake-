extends CharacterBody3D

signal melee_attack(damage: float)

@export var walk_speed: float = 5.0
@export var sprint_speed: float = 9.0
@export var jump_velocity: float = 6.0
@export var gravity_scale: float = 1.0
@export var mouse_sensitivity: float = 0.002
@export var max_stamina: float = 100.0
@export var stamina_drain_per_second: float = 22.0
@export var stamina_recover_per_second: float = 16.0
@export var melee_damage: float = 35.0

@onready var pivot: Node3D = $CameraPivot

var _yaw := 0.0
var _pitch := -0.2
var stamina: float = max_stamina

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_yaw -= event.relative.x * mouse_sensitivity
		_pitch -= event.relative.y * mouse_sensitivity
		_pitch = clamp(_pitch, -1.2, 1.2)
		rotation.y = _yaw
		pivot.rotation.x = _pitch
	if event.is_action_pressed("look_capture"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("attack"):
		emit_signal("melee_attack", melee_damage)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * gravity_scale * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var input_vec := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_vec.x, 0, input_vec.y)).normalized()
	var trying_sprint := Input.is_action_pressed("sprint") and direction != Vector3.ZERO
	var can_sprint := trying_sprint and stamina > 0.5
	var speed := sprint_speed if can_sprint else walk_speed

	if can_sprint:
		stamina = max(0.0, stamina - stamina_drain_per_second * delta)
	else:
		stamina = min(max_stamina, stamina + stamina_recover_per_second * delta)

	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed)
		velocity.z = move_toward(velocity.z, 0, walk_speed)
	move_and_slide()

func stamina_percent() -> float:
	return (stamina / max_stamina) * 100.0
