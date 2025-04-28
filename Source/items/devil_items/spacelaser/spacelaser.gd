extends devil_items

@export var uses:int = 1
var is_being_used:bool = false

func _ready():
	SignalBus.connect("laser_attack", decrement_uses)
	
func decrement_uses():
	SignalBus.emit_signal("clear_devil_item")
	queue_free()
