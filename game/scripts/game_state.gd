extends Node

var unlocked_map_cells: Dictionary = {}
var activated_towers: Dictionary = {}
var story_flags: Dictionary = {"intro_complete": false, "chapter": 1}

func unlock_map_cell(cell: Vector2i) -> void:
	unlocked_map_cells[cell] = true

func unlock_region(center: Vector2i, radius: int = 3) -> void:
	for z in range(center.y - radius, center.y + radius + 1):
		for x in range(center.x - radius, center.x + radius + 1):
			unlocked_map_cells[Vector2i(x, z)] = true

func activate_tower(tower_id: String, cell: Vector2i) -> void:
	activated_towers[tower_id] = true
	unlock_region(cell, 5)
