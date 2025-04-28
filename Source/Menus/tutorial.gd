extends CanvasLayer


@onready var game_container = get_parent()
@export var is_versus:bool = true
var curr_index:int = 0

func _ready():
	Engine.time_scale = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	for ch in $Control2.get_children():
		ch.visible = false
	$Control2.get_child(0).visible = true



func _on_back_pressed():
	game_container.spawn_main_menu()
	self.queue_free()


func _on_versus_pressed():
	curr_index += 1
	if curr_index >= $Control2.get_child_count():
		$Control2.get_child(11).visible = false
		$Control2.get_child(0).visible = true
		curr_index = 0
	else:
		$Control2.get_child(curr_index).visible = true
		$Control2.get_child(curr_index-1).visible = false
		


func _on_versus_2_pressed():
	curr_index -= 1
	if curr_index < 0:
		$Control2.get_child(11).visible = true
		$Control2.get_child(0).visible = false
		curr_index = 11
	else:
		$Control2.get_child(curr_index).visible = true
		$Control2.get_child(curr_index+1).visible = false
	pass # Replace with function body.
