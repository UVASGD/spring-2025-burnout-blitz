extends Node3D

@onready var idle_player:AnimationPlayer = %idle_player
@onready var despawn_player:AnimationPlayer = %despawn_player
@onready var regen_timer:Timer = $regen_timer

@export var regen_time_seconds:int = 5

var item_available:bool = true

func _ready():
	#idle_player.play("idle")
	item_available = true
	regen_timer.wait_time = regen_time_seconds

		
func _on_area_3d_body_entered(body):
	if item_available and (body.is_in_group("driver") or body.is_in_group("enemy")):
		item_available = false
		despawn_player.play("despawn")
		emit_signal("item_taken")
		regen_timer.start()
		

func _on_regen_timer_timeout():
	despawn_player.play_backwards("despawn")
	await despawn_player.animation_finished
	item_available = true
