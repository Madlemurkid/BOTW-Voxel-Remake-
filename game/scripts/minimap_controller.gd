extends SubViewport

@export var texture_rect_path: NodePath = NodePath("../Minimap")

@export var target_path: NodePath
@onready var camera: Camera3D = $MiniCam

var target: Node3D

func _ready() -> void:
	target = get_node_or_null(target_path)
	var rect := get_node_or_null(texture_rect_path) as TextureRect
	if rect:
		rect.texture = get_texture()

func _process(_delta: float) -> void:
	if target == null:
		return
	var pos := target.global_position
	camera.global_position = Vector3(pos.x, 50.0, pos.z)
	camera.rotation = Vector3(-PI / 2.0, 0, 0)
