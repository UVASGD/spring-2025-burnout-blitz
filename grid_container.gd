extends GridContainer

@onready var left_side = %left_side
@onready var right_side = %right_side

func _ready():
	left_side.handle_input_locally = false
	right_side.handle_input_locally = true
	$".".add_theme_constant_override("h_separation", 0)
