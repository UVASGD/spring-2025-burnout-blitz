extends VehicleBody3D

const STEER_SPEED = 1.5
const STEER_LIMIT = 0.4
const ENGINE_POWER = 300

var previous_speed := linear_velocity.length()

func _physics_process(delta: float):
	var fwd_mps := (linear_velocity * transform.basis).x

	steering = move_toward(steering, Input.get_axis("turn_right", "turn_left") * STEER_LIMIT, STEER_SPEED * delta)
	engine_force = Input.get_axis("move_back", "move_forward") * ENGINE_POWER

	previous_speed = linear_velocity.length()
