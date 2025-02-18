class_name checkpoint extends Node3D
var is_active:bool = false
var is_startpoint:bool = false
@onready var driver:VehicleBody3D = %Driver


func _ready():
	SignalBus.connect("update_checkpoint", decativate_checkpoint)
	SignalBus.connect("out_of_bounds", tele_to_checkpoint)


func _on_area_3d_body_entered(body):
	if !is_active and body.is_in_group("driver"):
		is_active = true
		SignalBus.emit_signal("update_checkpoint")
		
func decativate_checkpoint():
	is_active = false
	
func tele_to_checkpoint():
	if is_active:
		%Driver.global_position
		
		
