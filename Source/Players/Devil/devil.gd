extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var pivot = %twist # Handles pitch (vertical rotation)
@onready var head = %head
@onready var camera

@onready var normal_camera = %Camera3D
@onready var top_camera = %top_camera
@export var sens = 0.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var screen_width = get_viewport().get_visible_rect().size.x
@onready var screen_height = get_viewport().get_visible_rect().size.y
@onready var right_viewport_start_x = screen_width / 2

@export var camera_move_speed:int = 2

var top_camera_active:bool = false
@export var top_camera_speed:float = 50.0  # Speed for moving the top camera
var top_camera_offset:Vector3 = Vector3(0, 100, 0)  # Raise the camera above the player

func _ready():
	# Lock and hide the mouse
	camera = normal_camera
	camera.current = true
	top_camera.current = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseButton and not top_camera_active:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and not top_camera_active:
		if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * sens))
			pivot.rotation.x = clamp(
				pivot.rotation.x - deg_to_rad(event.relative.y * sens),
				deg_to_rad(-90),  # Minimum pitch angle
				deg_to_rad(45)    # Maximum pitch angle
			)
			head.rotation.x = pivot.rotation.x
			head.rotation.y = pivot.rotation.y
			#print("marker rotation" + str($head/Node3D.rotation.y))

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump
	if Input.is_action_just_pressed("jump") and is_on_floor() and not top_camera_active:
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("switch_devil_camera"):
		switch_camera()
	
	if top_camera_active:
		move_top_camera(delta)
	else:
		move_character(delta)

	move_and_slide()

func move_character(delta):
	# Normal movement when not in top camera mode
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
func move_top_camera(delta):
	# Move the top camera instead of the character
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var movement = Vector3(input_dir.x, 0, input_dir.y) * top_camera_speed * delta
	top_camera.global_translate(movement)

func switch_camera():
	if camera == normal_camera:
		# Move top camera above the character
		top_camera.global_transform.origin = global_transform.origin + top_camera_offset
		top_camera.look_at(global_transform.origin)  # Make it look down at the devil
		camera = top_camera
		top_camera_active = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		velocity = Vector3.ZERO
	else:
		camera = normal_camera
		top_camera_active = false
		# Reset top camera position
		top_camera.global_transform.origin = global_transform.origin
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	SignalBus.emit_signal("toggle_crosshair")
	await get_tree().process_frame  # Ensure changes take effect before continuing
	camera.current = true

# This is the method to convert the crosshair position (Vector2) to a world position (Vector3)
