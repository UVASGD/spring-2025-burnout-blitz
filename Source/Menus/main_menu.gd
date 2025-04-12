extends CanvasLayer
class_name MainMenu

@onready var game_container = get_parent()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Engine.time_scale = 1



func _on_versus_pressed() -> void:
	# Variable within the function is is_versus which is set to true
	game_container.spawn_map_select_menu(true)
	queue_free()	


func _on_time_trials_pressed():
	# Variable within the function is is_versus which is set to false since this is time trials
	game_container.spawn_map_select_menu(false)
	queue_free()	
