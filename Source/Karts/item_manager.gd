extends Node3D
@onready var boost = preload("res://Source/items/driver_items/boost.tscn")
@onready var animation_player = %AnimationPlayer

var all_items:Array[String] = ["boost"]
func _ready():
	SignalBus.connect("driver_play_animation", play_animation)
	SignalBus.connect("driver_giving_item", insert_item)
	pass

func insert_item(item_name:String):
	if item_name in all_items:
		var item
		match item_name:
			"boost":
				item = boost.instantiate()
				add_child(item)
				#$".".get_child(1).hide()
				item.global_transform.origin = $".".global_transform.origin
func _input(event):
	if event.is_action_pressed("use_driver_item"):
		use_item()

func use_item():
	if $".".get_child_count() > 1:
		var child_node = $".".get_child(1)
		child_node.use() 
		
func play_animation(anim_name:String):
	animation_player.play(anim_name)
