extends Node3D
class_name DevilItemManager

@onready var boost = preload("res://Source/items/driver_items/boost.tscn")
@onready var trident = preload("res://Source/items/devil_items/trident/trident.tscn")
@onready var missile = preload("res://Source/items/devil_items/missile/missile.tscn")

var all_items:Array[String] = ["trident", "missile"]
func _ready():
	SignalBus.connect("devil_giving_item", insert_item)

func insert_item(item_name:String):
	if item_name in all_items:
		var item
		match item_name:
			#"boost":
				#item = boost.instantiate()
				#add_child(item)
				##$".".get_child(1).hide()
				#item.global_transform.origin = self.global_transform.origin
			"trident":
				item = trident.instantiate()
				add_child(item)
				item.global_transform.origin = self.global_transform.origin
			"missile":
				item = missile.instantiate()
				add_child(item)
				item.global_transform.origin = self.global_transform.origin

				

func _input(event):
	if event.is_action_pressed("use_devil_item"):
		use_item()

func use_item():
	if self.get_child_count() > 1:
		var child_node = self.get_child(1)
		child_node.use()
