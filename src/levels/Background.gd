extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var orig_pos : Vector2
var orig_size : Vector2
var scroll_speed := 3
# Called when the node enters the scene tree for the first time.
func _ready():
	orig_pos = rect_position
	orig_size = rect_size
	
func _physics_process(delta):
	rect_position.y += scroll_speed
	if  rect_position.y - orig_pos.y >= orig_size.y:
		rect_position.y = orig_pos.y# - orig_size.y
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass