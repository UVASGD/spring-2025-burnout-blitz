extends Node3D
class_name GameContainer

@onready var main_menu_scene = preload("res://Source/Menus/main_menu.tscn")
@onready var map_select_menu_scene = preload("res://Source/Menus/map_select_menu.tscn")

@onready var levels = {
	1 : preload("res://Source/Levels/missile_test.tscn"),
	2 : 2,
	3 : 3
}

func _ready():
	spawn_main_menu()
	
func spawn_main_menu():
	var main_menu_inst = main_menu_scene.instantiate()
	add_child(main_menu_inst)
	
func spawn_map_select_menu():
	var map_select_menu_inst = map_select_menu_scene.instantiate()
	add_child(map_select_menu_inst)

func spawn_level(id : int):
	var level_inst = levels.get(id).instantiate()
	#level_inst.global_position = Vector3(0,0,0)
	add_child(level_inst)
