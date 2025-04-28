extends CanvasLayer
class_name MapSelect

@onready var game_container = get_parent()
@export var is_versus:bool = true

func _ready():
	Engine.time_scale = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func _on_button_pressed() -> void:
	if is_versus:
		game_container.spawn_level("V_Violence")
	else:
		game_container.spawn_level("T_Violence")
	self.queue_free()


func _on_back_pressed():
	game_container.spawn_main_menu()
	self.queue_free()


func _on_button_2_pressed():
	if is_versus:
		game_container.spawn_level("V_Greed")
	else:
		game_container.spawn_level("T_Greed")
	self.queue_free()
