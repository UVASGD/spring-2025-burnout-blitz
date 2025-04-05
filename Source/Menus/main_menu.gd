extends CanvasLayer
class_name MainMenu

@onready var game_container = get_parent()

func _on_button_pressed() -> void:
	game_container.spawn_map_select_menu()
	queue_free()
