extends Area3D

@onready var anim_player = %AnimationPlayer
@export var explosion_force_amount:int = 5000

func play_explosion_anim():
	anim_player.play("explosion")

func _on_animation_player_animation_finished(anim_name):
	self.queue_free()
	pass # Replace with function body.


func _on_body_entered(body):
	if body.is_in_group("driver"):
		var direction = (body.global_transform.origin - global_transform.origin).normalized()
		var force = direction * 10000  
		body.apply_impulse(force, Vector3.ZERO)
