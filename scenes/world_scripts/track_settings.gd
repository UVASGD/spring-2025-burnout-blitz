class_name track_settings extends Node3D

@export var driver_items:Array[String] = []

func _ready():
	SignalBus.connect("item_taken", give_driver_item)
	
func give_driver_item():
	if not driver_items.is_empty():
		var total_items:int = len(driver_items) - 1
		var random_item_number:int = randi_range(0, total_items)
		var random_item_name:String = driver_items[random_item_number]		
		SignalBus.emit_signal("giving_item", random_item_name)
		print("giving item: " + random_item_name)
