extends CharacterBody3D

signal boss_defeated

@export var max_health: float = 600.0
@export var move_speed: float = 4.5
@export var aggro_range: float = 45.0
@export var melee_range: float = 3.5

var health: float
var active: bool = false
@onready var player: Node3D = get_node_or_null("../Player")

func _ready() -> void:
	health = max_health
	visible = false

func activate_boss(spawn_position: Vector3) -> void:
	global_position = spawn_position
	active = true
	visible = true
	set_physics_process(true)

func _physics_process(_delta: float) -> void:
	if not active or not player:
		return
	var to_player := player.global_position - global_position
	var distance := to_player.length()
	if distance <= aggro_range and distance > melee_range:
		var dir := to_player.normalized()
		velocity = Vector3(dir.x * move_speed, velocity.y, dir.z * move_speed)
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z))
	elif distance <= melee_range:
		velocity.x = 0
		velocity.z = 0
	move_and_slide()

func apply_damage(amount: float) -> void:
	if not active:
		return
	health -= amount
	if health <= 0:
		active = false
		emit_signal("boss_defeated")
		queue_free()

func health_percent() -> float:
	return max(0.0, (health / max_health) * 100.0)

func is_boss_active() -> bool:
	return active
