extends CanvasLayer


@onready var game_container = get_parent()
@export var is_versus:bool = true
var curr_index:int = 0

func _ready():
	Engine.time_scale = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _on_back_pressed():
	game_container.spawn_main_menu()
	self.queue_free()
