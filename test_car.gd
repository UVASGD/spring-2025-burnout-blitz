extends VehicleBody3D

@export var MAX_STEER:float = 0.9
@export var default_engine_power: float = 300
@export var boost_multiplier: float = 2

@onready var animation_player = %AnimationPlayer
var ENGINE_POWER:float = 300
var is_boosting:bool = false
var is_item_being_used:bool = false



func _ready():
	ENGINE_POWER = default_engine_power

func _physics_process(delta):
	steering = move_toward(steering, Input.get_axis("move_right", "move_left") * MAX_STEER, delta * 10)
	engine_force = Input.get_axis("move_back", "move_forward") * ENGINE_POWER
	if !is_boosting:
		_boost_test()
	else:
		ENGINE_POWER -= 10
		ENGINE_POWER = max(ENGINE_POWER, default_engine_power)
		if ENGINE_POWER == default_engine_power:
			is_boosting = false

func _boost_test():
	if Input.is_action_just_pressed("drift") and !is_boosting:
		animation_player.play("flame")
		ENGINE_POWER *= boost_multiplier
		is_boosting = true
		
func use_item():
	if !is_item_being_used:
		pass
	
