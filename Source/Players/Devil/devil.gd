extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var oil_spill = preload("res://Source/items/devil_items/oil_spill/oil_spill_inst.tscn")

@onready var pivot = %twist # Handles pitch (vertical rotation)
@onready var head = %head
@onready var camera
@onready var item_manager = %item_manager

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
	
	if Input.is_action_just_pressed("left_click"):
		left_click()
	if Input.is_action_just_pressed('test_controllable_button'):
		var controllable_nodes = get_tree().get_nodes_in_group("controllable")
		switch_to_controllable(controllable_nodes[1].name)
	
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
		rotation = Vector3(0, 0, 0)
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

func left_click():
	if item_manager.get_child_count() == 2 and item_manager.get_child(1).is_top_down and top_camera_active:
		var item = item_manager.get_child(1)
		
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_length = 1000
		var from = top_camera.project_ray_origin(mouse_pos)
		var to = from + top_camera.project_ray_normal(mouse_pos) * ray_length
		var space = top_camera.get_world_3d().direct_space_state
		var ray_query = PhysicsRayQueryParameters3D.new()
		
		ray_query.from = from
		ray_query.to = to
		var raycast_result = space.intersect_ray(ray_query)
		
		if raycast_result:
			var detected_obj = raycast_result.get("collider")
			if detected_obj.is_in_group("controllable"):
				switch_to_controllable(name)
				print("obtained object!")
			else:
				print("uh oh")
			var insert_position = (raycast_result.get("position"))
			print("ray result: ", insert_position)
			item.use_top_down(insert_position, get_parent())
			
		#if raycast_result:
			#var oil_inst = oil_spill.instantiate()
			#get_parent().add_child(oil_inst)
			#oil_inst.global_position = Vector3(raycast_result.get("position"))

func switch_to_controllable(c_name):
	SignalBus.emit_signal("change_screen_visibility", "SubViewportContainer2")
	SignalBus.emit_signal("change_screen_visibility", "Controllable")
	SignalBus.emit_signal("activate_controllable", c_name)
	pass

	
# This is the method to convert the crosshair position (Vector2) to a world position (Vector3)
