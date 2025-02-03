extends Node3D


var has_item:bool = false
var item_box = preload("res://Assets/items/item_box/itembox.tscn")

func _ready():
	spawn_item()
	has_item = true
	pass
	
func spawn_item():
	if !has_item:
		var item_instance = item_box.instantiate()
		$spawn_point.add_child(item_instance)
		has_item = true
