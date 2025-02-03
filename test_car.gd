extends VehicleBody3D

@export var MAX_STEER:float = 0.9
@export var power_curve : Curve
@export var steering_curve : Curve

@export var default_engine_power: float = 300
@export var boost_multiplier: float = 2

@onready var animation_player = %AnimationPlayer
var ENGINE_POWER:float = 300
var is_boosting:bool = false

var acceleration_time : float = 0
var steering_time : float = 0



func _ready():
	ENGINE_POWER = default_engine_power

func _physics_process(delta):
	
	
	var factor = 0
	var dir = Input.get_axis("move_back", "move_forward")
	var steer_direction = Input.get_axis("move_right", "move_left")
	
	var steer_factor
	
	if dir == 0:
		acceleration_time -= delta
	else:
		acceleration_time += delta
		
	if steer_direction == 0:
		steer_factor = delta * 10
		steering_time = 0
	else:
		steer_factor = delta * 10 * steering_curve.sample(steering_time)
		steering_time += delta
	
	steering_time = clamp(steering_time, 0, 1)
	acceleration_time = clamp(acceleration_time, 0, 1)
	
	engine_force = power_curve.sample(acceleration_time) * dir * ENGINE_POWER
	
	
	
	steering = move_toward(steering, steer_direction * MAX_STEER, steer_factor)
	
	if !is_boosting:
		_boost_test()
	else:
		ENGINE_POWER -= 10
		ENGINE_POWER = max(ENGINE_POWER, default_engine_power)
		if ENGINE_POWER == default_engine_power:
			is_boosting = false

func _boost_test():
	if Input.is_action_just_pressed("use_driver_item") and !is_boosting:
		animation_player.play("flame")
		ENGINE_POWER *= boost_multiplier
		is_boosting = true
