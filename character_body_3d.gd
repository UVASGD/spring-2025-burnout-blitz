extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var pivot = %camera_origin # Handles pitch (vertical rotation)
@onready var camera = %Camera3D # Your Camera node
@export var sens = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		# Rotate horizontally around the CharacterBody3D (yaw)
		rotate_y(deg_to_rad(-event.relative.x * sens))

		# Rotate vertically around the pivot (pitch)
		pivot.rotation.x = clamp(pivot.rotation.x - deg_to_rad(event.relative.y * sens), deg_to_rad(-90), deg_to_rad(45))

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	# Get the input direction and handle the movement/deceleration
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
