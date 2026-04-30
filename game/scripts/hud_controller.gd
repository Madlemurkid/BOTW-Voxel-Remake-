extends CanvasLayer

@onready var objective_label: Label = $ObjectiveLabel
@onready var stamina_bar: ProgressBar = $StaminaBar
@onready var tower_prompt: Label = $TowerPrompt
@onready var boss_bar: ProgressBar = $BossHealthBar

@onready var player: Node = get_node_or_null("../Player")
@onready var story: Node = get_node_or_null("../StoryManager")
@onready var boss: Node = get_node_or_null("../Boss")

func _ready() -> void:
	if story:
		objective_label.text = "Objective: %s" % story.current_objective()
		story.story_updated.connect(_on_story_updated)
	tower_prompt.visible = false
	boss_bar.visible = false

func _process(_delta: float) -> void:
	if player and player.has_method("stamina_percent"):
		stamina_bar.value = player.stamina_percent()
	if boss and boss.has_method("health_percent") and boss.has_method("is_boss_active"):
		boss_bar.visible = boss.is_boss_active()
		boss_bar.value = boss.health_percent()

func _on_story_updated(_chapter: int, objective: String) -> void:
	objective_label.text = "Objective: %s" % objective

func show_tower_prompt(show: bool) -> void:
	tower_prompt.visible = show
