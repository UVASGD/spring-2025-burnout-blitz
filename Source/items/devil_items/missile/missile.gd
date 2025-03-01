extends devil_items

@export var speed:int = 50
@export var rotation_speed:int = 3
@export var explosion_force_amount:int = 5000
var is_being_used:bool = false

var missile_instance = preload("res://Source/items/devil_items/missile/missile_instance.tscn")

func _ready():
	is_being_used = false

func use():
	if !is_being_used:
		is_being_used = true
		var m_instance = missile_instance.instantiate()
		m_instance.speed = speed
		m_instance.rotation_speed = rotation_speed
		m_instance.explosion_force_amount = explosion_force_amount
		m_instance.global_transform.origin = self.global_transform.origin
		var spawn_pos = self.global_transform.origin
		spawn_pos.y += -1


		var root_scene = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
		root_scene.add_child(m_instance)
		SignalBus.emit_signal("clear_devil_item")
		self.queue_free()
		#get_parent().add_child(m_instance)
