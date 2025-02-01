extends Node3D

var has_item:bool = false

func _ready():
	spawn_item()
	has_item = true
	pass
	
func spawn_item():
	if !has_item:
		
	
