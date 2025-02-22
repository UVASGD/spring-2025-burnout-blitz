extends Control



func _ready():
	SignalBus.connect("driver_giving_item", update_item_label)
	SignalBus.connect("clear_item", clear)
	SignalBus.connect("update_laps_left", update_laps_left_label)
	
func update_item_label(item_name:String):
	$current_item.text = item_name

func clear():
	$current_item.text = ""

func update_laps_left_label(laps_left:String):
	%laps_left.text = laps_left

	
