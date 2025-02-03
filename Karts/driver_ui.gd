extends Control



func _ready():
	SignalBus.connect("giving_item", update_item_label)
	
func update_item_label(item_name:String):
	$current_item.text = item_name

	
