extends CharacterBody3D


@onready var Camera:Camera3D = %Camera3D
@onready var Rotator:Node3D = %Rotator
@onready var anim_player:AnimationPlayer = %AnimationPlayer

var is_on = false
var can_rotate = true
var rot_speed:float = 0.005
var horizontal_angle:float = 0.0

func _ready():
	SignalBus.connect("activate_controllable", turn_on)
	Camera.current = true
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed("left_click"):
		attack()
	
func _unhandled_input(event):
	if event is InputEventMouseMotion and is_on and can_rotate:
		horizontal_angle -= event.relative.x * rot_speed
		
		Rotator.rotation.y = horizontal_angle
	
	

func turn_on(c_name):
	if c_name == self.name:
		is_on = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func exit():
	is_on = false
	
func attack():
	can_rotate = false
	anim_player.play("attack")
	await anim_player.animation_finished
	can_rotate = true
	




	pass # Replace with function body.


func _on_area_3d_body_entered(body):
	if body.is_in_group("driver") and not body.invul_on:
		var direction = (body.global_transform.origin - global_transform.origin).normalized()

		var upward_boost = 1000
		# Add upward force
		direction.y += upward_boost  
		direction = direction.normalized()  # Normalize to prevent excessive force in any direction
		
		var explosion_force_amount = 500
		# Apply impulse
		var force = direction * explosion_force_amount  
		body.apply_impulse(force, Vector3.ZERO)
