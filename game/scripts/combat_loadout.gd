extends Node

var weapons: Array = []
var arrows: Array = []
var selected_weapon_index: int = 0
var selected_arrow_index: int = 0

func _ready() -> void:
	_load_data()

func _load_data() -> void:
	var file := FileAccess.open("res://data/weapons.json", FileAccess.READ)
	if not file:
		return
	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) == TYPE_DICTIONARY:
		weapons = parsed.get("weapons", [])
		arrows = parsed.get("arrows", [])

func selected_weapon() -> Dictionary:
	if weapons.is_empty():
		return {}
	return weapons[selected_weapon_index]

func selected_arrow() -> Dictionary:
	if arrows.is_empty():
		return {}
	return arrows[selected_arrow_index]

func cycle_weapon() -> void:
	if weapons.is_empty():
		return
	selected_weapon_index = (selected_weapon_index + 1) % weapons.size()

func cycle_arrow() -> void:
	if arrows.is_empty():
		return
	selected_arrow_index = (selected_arrow_index + 1) % arrows.size()
