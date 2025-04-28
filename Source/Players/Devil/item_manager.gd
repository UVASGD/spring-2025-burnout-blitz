extends Node3D
class_name DevilItemManager

@onready var sigil_anim_player = %sigil_anim_player

@onready var trident = preload("res://Source/items/devil_items/trident/trident.tscn")
@onready var missile = preload("res://Source/items/devil_items/missile/missile.tscn")
@onready var oil_spill = preload("res://Source/items/devil_items/oil_spill/oil_spill.tscn")
@onready var black_hole = preload("res://Source/items/devil_items/black hole/black_hole.tscn")
@onready var shark = preload("res://Source/items/devil_items/shark/shark.tscn")
@onready var bagger = preload("res://Source/items/devil_items/Bagger/bagger.tscn")
@onready var breakable_wall = preload("res://Source/items/devil_items/breakablewall/breakable_wall.tscn")
@onready var ufo = preload("res://Source/items/devil_items/UFO/ufo.tscn")
@onready var spacelaser = preload("res://Source/items/devil_items/spacelaser/spacelaser.tscn")

var all_items:Array[String] = ["trident", "missile", "shark", "oil_spill", "bagger", "breakable_wall", "black_hole", "ufo", "spacelaser"]

var norm_0_top_1_control_2: int
func _ready():
	SignalBus.connect("devil_giving_item", insert_item)

func insert_item(item_name:String):
	if item_name in all_items:
		var item
		match item_name:
			"trident":
				norm_0_top_1_control_2 = 0
				sigil_anim_player.play("sigil_spawn")
				item = trident.instantiate()
				add_child(item)
				item.global_transform.origin = self.global_transform.origin
			"missile":
				norm_0_top_1_control_2 = 0
				sigil_anim_player.play("sigil_spawn")
				item = missile.instantiate()
				add_child(item)
				item.global_transform.origin = self.global_transform.origin
			"oil_spill":
				norm_0_top_1_control_2 = 1
				sigil_anim_player.play("sigil_spawn_top_down")
				item = oil_spill.instantiate()
				add_child(item)
				item.global_transform.origin = self.global_transform.origin
			"bagger":
				norm_0_top_1_control_2 = 2
				sigil_anim_player.play("sigil_spawn_top_down_controllable")
				item = bagger.instantiate()
				add_child(item)
				item.global_transform.origin = self.global_transform.origin		
			"black_hole":
				norm_0_top_1_control_2 = 1
				sigil_anim_player.play("sigil_spawn_top_down")
				item = black_hole.instantiate()
				add_child(item)
				item.global_transform.origin = self.global_transform.origin
			"shark":
				norm_0_top_1_control_2 = 1
				sigil_anim_player.play("sigil_spawn_top_down")
				item = shark.instantiate()
				add_child(item)
				item.global_transform.origin = self.global_transform.origin
			"breakable_wall":
				norm_0_top_1_control_2 = 1
				sigil_anim_player.play("sigil_spawn_top_down")
				item = breakable_wall.instantiate()
				add_child(item)
				item.global_transform.origin = self.global_transform.origin
			"ufo":
				norm_0_top_1_control_2 = 1
				sigil_anim_player.play("sigil_spawn_top_down")
				item = ufo.instantiate()
				add_child(item)
				item.global_transform.origin = self.global_transform.origin
			"spacelaser":
				norm_0_top_1_control_2 = 2
				sigil_anim_player.play("sigil_spawn_top_down_controllable")
				item = spacelaser.instantiate()
				add_child(item)
				item.global_transform.origin = self.global_transform.origin

				

func _input(event):
	if event.is_action_pressed("use_devil_item"):
		use_item()

func use_item():
	if self.get_child_count() > 1:
		var child_node = self.get_child(1)
		child_node.use()
		if child_node.num_uses <= 0:
			match norm_0_top_1_control_2:
				1:
					sigil_anim_player.play_backwards("sigil_spawn")
				2:
					sigil_anim_player.play_backwards("sigil_spawn_top_down")
				3:
					sigil_anim_player.play_backwards("sigil_spawn_top_down_controllable")
			
		
