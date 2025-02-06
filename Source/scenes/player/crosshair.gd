extends CenterContainer
@export var crosshair_radius: float = 4.0
@export var crosshair_color: Color = Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready():
	queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _draw():
	draw_circle(Vector2(20,20),crosshair_radius, crosshair_color)


	
	
	
