extends SubViewportContainer

@export var player_camera: Camera3D:
	get: return dithering_camera
	set(value):
		dithering_camera = value
		if dithering_camera and camera_3d:
			camera_3d.projection = dithering_camera.projection
			camera_3d.size = dithering_camera.size

@onready var viewport: SubViewport = $viewport
@onready var camera_3d: Camera3D = $viewport/Camera3D

var dithering_camera: Camera3D


func _process(delta: float) -> void:
	if dithering_camera and camera_3d:
		camera_3d.global_transform = dithering_camera.global_transform
