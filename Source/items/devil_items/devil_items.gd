class_name devil_items extends Node
@export var item_name: String
@export var animation_name: String


func use():
	pass

func play_animation(animation_name):
	SignalBus.emit_signal("devil_play_animation", animation_name)
