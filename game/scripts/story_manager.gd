extends Node

signal story_updated(chapter: int, objective: String)

var chapter_objectives := {
	1: "Reach Relay Alpha and hold [E] to activate it.",
	2: "Defeat the Warden that appears near the relay.",
	3: "Section complete. Fast travel and map unlock are online."
}

@onready var state: Node = get_node_or_null("/root/GameState")

func current_objective() -> String:
	var chapter := int(state.story_flags.get("chapter", 1)) if state else 1
	return chapter_objectives.get(chapter, "Explore the frontier.")

func advance_to_chapter(target: int) -> void:
	if not state:
		return
	state.story_flags["chapter"] = clamp(target, 1, 3)
	emit_signal("story_updated", int(state.story_flags["chapter"]), current_objective())
