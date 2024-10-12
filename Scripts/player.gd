extends CharacterBody3D


@export var speed := 8.0
@export var camera_vertical_limits = Vector2(-90.0, 90.0)

@onready var camera_pivot: Node3D = $CameraPivot
@onready var smooth_camera: Camera3D = %SmoothCamera


var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_motion := Vector2.ZERO
var fall_multiplier := 2.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	handle_camera_rotation()

	if not is_on_floor():
		if velocity.y >= 0: 
			velocity.y -= gravity * delta
		else:
			velocity.y -= gravity * delta * fall_multiplier

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()


#region Mouse Input
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			mouse_motion = -event.relative * 0.001
		
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func handle_camera_rotation() -> void:
	rotate_y(mouse_motion.x)
	camera_pivot.rotate_x(mouse_motion.y)
	camera_pivot.rotation_degrees.x = clamp(
		camera_pivot.rotation_degrees.x, camera_vertical_limits.x, camera_vertical_limits.y
	)
	mouse_motion = Vector2.ZERO
#endregion
