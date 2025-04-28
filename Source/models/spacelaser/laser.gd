
extends RayCast3D

var is_laser_on = false
@export var max_length = -1000000000000000
@export var min_length = -0.1
@onready var beam = $beam_mesh
@onready var coll_shape = $beam_mesh/Area3D/CollisionShape3D
var length
func _ready():
	is_laser_on = false
	#change_beam_length(-100)


func _process(delta):
	if is_laser_on:
		var contact_point
		
		force_raycast_update()
		
		if is_colliding():
			var collider = get_collider()
			contact_point = to_local(get_collision_point())
			length = contact_point.y
			if collider.is_in_group("track") or collider.is_in_group("driver"):
				length += -5
			#else:
				#length = 0
			
			change_beam_length(length)

func change_beam_length(length):
	beam.mesh.height = length
	beam.position.y = length/2
	coll_shape.shape.height = length
	coll_shape.position.y = length / 2
func activate():
	is_laser_on = true
	change_beam_length(-100)

	visible = true
	
func deactivate():
	is_laser_on = false
	visible = false
	change_beam_length(0)



func _on_area_3d_body_entered(body):
	if body.is_in_group("driver") and not body.invul_on and not body.force_being_applied:
		body.force_being_applied = true
		var direction = (body.global_transform.origin - global_transform.origin).normalized()
		var upward_boost = 10000
		var explosion_force_amount = 5000

		# Add upward force
		direction.y += upward_boost  
		direction = direction.normalized()  # Normalize to prevent excessive force in any direction

		# Apply impulse
		var force = direction * explosion_force_amount  
		body.apply_impulse(force, Vector3.ZERO)
		body.force_being_applied = false
