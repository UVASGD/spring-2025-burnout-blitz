extends CanvasLayer
class_name MapSelectMenu

@onready var game_container = get_parent()

func _on_button_pressed() -> void:
	game_container.spawn_level(1)
	queue_free()
