extends Node

@onready var player: Node = get_node_or_null("../Player")
@onready var boss: Node = get_node_or_null("../Boss")
@onready var story: Node = get_node_or_null("../StoryManager")

func _ready() -> void:
	if player and boss and player.has_signal("melee_attack"):
		player.melee_attack.connect(_on_player_melee_attack)
	if boss and boss.has_signal("boss_defeated"):
		boss.boss_defeated.connect(_on_boss_defeated)

func _on_player_melee_attack(damage: float) -> void:
	if not boss:
		return
	if player.global_position.distance_to(boss.global_position) <= 4.0:
		boss.apply_damage(damage)

func _on_boss_defeated() -> void:
	if story:
		story.advance_to_chapter(3)
