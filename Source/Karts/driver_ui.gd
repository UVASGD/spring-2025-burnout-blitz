extends Control



func _ready():
	SignalBus.connect("driver_giving_item", update_item_label)
	SignalBus.connect("clear_item", clear)
	
func update_item_label(item_name:String):
	$current_item.text = item_name

func clear():
	$current_item.text = ""

	
