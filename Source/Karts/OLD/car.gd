extends VehicleBody3D

@export var camera_speed = 10
@export var max_steering = 0.9
@export var engine_power = 300

func _physics_process(delta):
	steering = Input.get_axis("move_right", "move_left") * 0.4
	engine_force = Input.get_axis("move_back", "move_forward") * 100
