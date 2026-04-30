extends Node3D

@export var world_size_meters: int = 18000
@export var chunk_size: int = 64
@export var voxel_scale: float = 1.0
@export var height_scale: float = 28.0
@export var noise_frequency: float = 0.0025
@export var chunks_visible_radius: int = 4

@onready var player: Node3D = get_node_or_null("../Player")

var noise := FastNoiseLite.new()
var chunk_root := Node3D.new()
var loaded_chunks: Dictionary = {}

func _ready() -> void:
	add_child(chunk_root)
	chunk_root.name = "ChunkRoot"
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = noise_frequency
	noise.fractal_octaves = 4
	noise.fractal_gain = 0.55
	noise.seed = randi()
	if player:
		_update_chunks(true)

func _process(_delta: float) -> void:
	if player:
		_update_chunks(false)

func _update_chunks(force: bool) -> void:
	var cx := int(floor(player.global_position.x / float(chunk_size)))
	var cz := int(floor(player.global_position.z / float(chunk_size)))
	var wanted: Dictionary = {}
	for z in range(cz - chunks_visible_radius, cz + chunks_visible_radius + 1):
		for x in range(cx - chunks_visible_radius, cx + chunks_visible_radius + 1):
			if not _chunk_in_bounds(x, z):
				continue
			var key := Vector2i(x, z)
			wanted[key] = true
			if force or not loaded_chunks.has(key):
				_load_chunk(key)

	for key in loaded_chunks.keys():
		if not wanted.has(key):
			_unload_chunk(key)

func _chunk_in_bounds(cx: int, cz: int) -> bool:
	var half_chunks := int((world_size_meters / chunk_size) / 2)
	return cx >= -half_chunks and cx <= half_chunks and cz >= -half_chunks and cz <= half_chunks

func _load_chunk(key: Vector2i) -> void:
	var chunk := StaticBody3D.new()
	chunk.name = "Chunk_%s_%s" % [key.x, key.y]
	chunk.position = Vector3(key.x * chunk_size * voxel_scale, 0, key.y * chunk_size * voxel_scale)

	var mesh_instance := MeshInstance3D.new()
	var plane := PlaneMesh.new()
	plane.size = Vector2(chunk_size * voxel_scale, chunk_size * voxel_scale)
	plane.subdivide_width = chunk_size
	plane.subdivide_depth = chunk_size
	mesh_instance.mesh = _build_height_mesh(plane, key)
	mesh_instance.create_trimesh_collision()

	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.32, 0.62, 0.31)
	mat.roughness = 1.0
	mesh_instance.material_override = mat

	chunk.add_child(mesh_instance)
	chunk_root.add_child(chunk)
	loaded_chunks[key] = chunk

func _unload_chunk(key: Vector2i) -> void:
	var node: Node = loaded_chunks[key]
	if is_instance_valid(node):
		node.queue_free()
	loaded_chunks.erase(key)

func _build_height_mesh(_plane: PlaneMesh, key: Vector2i) -> ArrayMesh:
	var st := SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	for z in range(chunk_size):
		for x in range(chunk_size):
			var p00 := _vertex_for(key, x, z)
			var p10 := _vertex_for(key, x + 1, z)
			var p01 := _vertex_for(key, x, z + 1)
			var p11 := _vertex_for(key, x + 1, z + 1)
			st.add_vertex(p00)
			st.add_vertex(p11)
			st.add_vertex(p10)
			st.add_vertex(p00)
			st.add_vertex(p01)
			st.add_vertex(p11)
	st.generate_normals()
	return st.commit()

func _vertex_for(key: Vector2i, lx: int, lz: int) -> Vector3:
	var wx := float(key.x * chunk_size + lx) * voxel_scale
	var wz := float(key.y * chunk_size + lz) * voxel_scale
	var h := noise.get_noise_2d(wx, wz) * height_scale
	return Vector3(float(lx) * voxel_scale, h, float(lz) * voxel_scale)
