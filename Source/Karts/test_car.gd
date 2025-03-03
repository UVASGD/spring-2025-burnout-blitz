extends VehicleBody3D

@export var power_curve : Curve
@export var MAX_STEER: float = 0.9
@export var steering_curve: Curve

var STEER_SPEED = 7.0  # Increased for quicker steering
var STEER_LIMIT = 0.5  # More responsive turning
var ENGINE_POWER = 400

@export var default_engine_power: float = 300
@export var boost_multiplier: float = 2

@onready var animation_player = %AnimationPlayer
var is_boosting: bool = false

var acceleration_time: float = 0
var steering_time: float = 0

func _ready():
	ENGINE_POWER = default_engine_power

var previous_speed := linear_velocity.length()

func _physics_process(delta: float):
	var fwd_mps := (linear_velocity * transform.basis).x

	# Improved Steering Responsiveness
	var steer_input = Input.get_axis("turn_right", "turn_left")
	steering = move_toward(steering, steer_input * STEER_LIMIT, STEER_SPEED * delta)

	# Improved Acceleration & Braking Response
	var throttle_input = Input.get_axis("move_back", "move_forward")
	engine_force = throttle_input * ENGINE_POWER

	# Flip Car Mechanic
	if Input.is_action_just_pressed("flip_car"):
		flip_car()

	previous_speed = linear_velocity.length()

# Function to flip the car if it's upside down or on its side
func flip_car():
	if global_transform.basis.y.dot(Vector3.UP) < 0.3:  # Checks if car is flipped
		var upright_transform = global_transform
		upright_transform.basis = Basis()  # Reset rotation
		upright_transform.origin += Vector3(0, 2, 0)  # Slightly lift the car
		global_transform = upright_transform
		linear_velocity = Vector3.ZERO  # Reset movement
		angular_velocity = Vector3.ZERO  # Reset spin


#func _physics_process(delta):
	#var factor = 0
	#var dir = Input.get_axis("move_back", "move_forward")
	#var steer_direction = Input.get_axis("move_right", "move_left")
	#var steer_factor
	#
	#if dir == 0:
		#acceleration_time -= delta
	#else:
		#acceleration_time += delta
		#
	#if steer_direction == 0:
		#steer_factor = delta * 20
		#steering_time = 0
	#else:
		##steer_factor = delta * 20 * steering_curve.sample(steering_time)
		#steer_factor = delta * 20
		#steering_time += delta
	#
	#steering_time = clamp(steering_time, 0, 1)
	#acceleration_time = clamp(acceleration_time, 0, 1)
	#
	#engine_force = power_curve.sample(acceleration_time) * dir * ENGINE_POWER
	#
	#
	#
	#steering = move_toward(steering, steer_direction * MAX_STEER, steer_factor)
	#
	#if !is_boosting:
		#_boost_test()
	#else:
		#ENGINE_POWER -= 10
		#ENGINE_POWER = max(ENGINE_POWER, default_engine_power)
		#if ENGINE_POWER == default_engine_power:
			#is_boosting = false

func update_engine_power(modifier:String, amount:float):
	match modifier:
		"add":
			ENGINE_POWER += amount
		"multiply":
			ENGINE_POWER *= amount
		"restore":
			ENGINE_POWER = default_engine_power

#func _boost_test():
	#if Input.is_action_just_pressed("use_driver_item") and !is_boosting:
		#animation_player.play("flame")
		#ENGINE_POWER *= boost_multiplier
		#is_boosting = true
