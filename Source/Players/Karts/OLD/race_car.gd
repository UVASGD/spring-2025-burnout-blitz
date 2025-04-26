#extends VehicleBody3D
#
#@export var MAX_STEER = 0.8
#@export var ENGINE_POWER = 1000
#func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#
#func _physics_process(delta):
	#steering = move_toward(steering, Input.get_axis("move_right", "move_left") * MAX_STEER, delta * 2.5)
	#engine_force = Input.get_axis("move_back", "move_forward") * ENGINE_POWER

extends VehicleBody3D

@export var MAX_STEER = 0.8
@export var ENGINE_POWER = 1000
@export var BRAKE_FORCE = 100


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Calculate steering and engine force
	var steer = Input.get_axis("move_left", "move_right")
	steering = steer
	var acceleration = Input.get_axis("back", "forward")
	engine_force = acceleration * 100
	
