class_name track_settings extends Node3D

@export var num_laps = 3
@export var driver_items_on_map:Array[String] = []

func _ready():
	SignalBus.connect("driver_item_taken", give_driver_item)
	
func give_driver_item():
	if not driver_items_on_map.is_empty():
		var total_items:int = len(driver_items_on_map) - 1
		var random_item_number:int = randi_range(0, total_items)
		var random_item_name:String = driver_items_on_map[random_item_number]		
		SignalBus.emit_signal("driver_giving_item", random_item_name)
		print("giving item: " + random_item_name)
