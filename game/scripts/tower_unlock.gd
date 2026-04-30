extends Area3D

@export var tower_id: String = "relay_alpha"
@export var map_cell: Vector2i = Vector2i(0, 0)
@export var hold_time_seconds: float = 1.2
@export var boss_spawn_point: Vector3 = Vector3(80, 20, 70)

@onready var state: Node = get_node_or_null("/root/GameState")
@onready var story: Node = get_node_or_null("../StoryManager")
@onready var hud: CanvasLayer = get_node_or_null("../HUD")
@onready var boss: Node = get_node_or_null("../Boss")

var _player_in_range: bool = false
var _activated: bool = false
var _hold_timer: float = 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(delta: float) -> void:
	if _activated or not _player_in_range:
		return
	if Input.is_action_pressed("interact"):
		_hold_timer += delta
		if _hold_timer >= hold_time_seconds:
			_activate_tower()
	else:
		_hold_timer = 0.0

func _on_body_entered(body: Node3D) -> void:
	if body.name != "Player":
		return
	_player_in_range = true
	if hud and hud.has_method("show_tower_prompt"):
		hud.show_tower_prompt(true)

func _on_body_exited(body: Node3D) -> void:
	if body.name != "Player":
		return
	_player_in_range = false
	_hold_timer = 0.0
	if hud and hud.has_method("show_tower_prompt"):
		hud.show_tower_prompt(false)

func _activate_tower() -> void:
	_activated = true
	if hud and hud.has_method("show_tower_prompt"):
		hud.show_tower_prompt(false)
	if state:
		state.activate_tower(tower_id, map_cell)
	if story:
		story.advance_to_chapter(2)
	if boss and boss.has_method("activate_boss"):
		boss.activate_boss(boss_spawn_point)
