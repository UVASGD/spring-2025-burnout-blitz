class_name checkpoint extends Node3D
var is_active:bool = false
var has_passed:bool = false
@export var is_startpoint:bool = false
@onready var driver:VehicleBody3D


func _ready():
	#if is_startpoint:
		#is_active = true
	SignalBus.connect("out_of_bounds", tele_to_checkpoint)
	SignalBus.connect("update_checkpoint", turn_off_checkpoint)
	driver = get_tree().get_nodes_in_group("driver")[0]


func _on_area_3d_body_entered(body):
	if !is_active and body.is_in_group("driver"):
		is_active = true
		has_passed = true
		print("checkpoint activated!")
		SignalBus.emit_signal("update_checkpoint", name)
		
	
func tele_to_checkpoint():
	if is_active:
		driver.global_transform.origin = global_transform.origin
		
func turn_off_checkpoint(nm:String):
	if nm != name:
		is_active = false
		
