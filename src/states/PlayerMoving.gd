class_name PlayerMoving
extends State

var last_direction : Vector2 = Vector2.ZERO
export (bool) var lean_on_move = false
export (int) var lean_angle = 10
export (float) var lean_duration = 0.5

func _ready():
	pass
	
func run(input):
	owner.position.x = clamp(owner.position.x, GameInfo.GAME_BORDER_START.x, GameInfo.GAME_BORDER_END.x)
	owner.position.y = clamp(owner.position.y, GameInfo.GAME_BORDER_START.y, GameInfo.GAME_BORDER_END.y)
#	position.x = clamp(position.x, GameInfo.GAME_BORDER_START.x, GameInfo.GAME_BORDER_END.x)
#	position.y = clamp(position.y, GameInfo.GAME_BORDER_START.y, GameInfo.GAME_BORDER_END.y)
	owner.direction = input.input_direction.normalized()
	var mult = 1
	if Input.is_action_pressed("move_slow") and owner.is_in_group("allies"):
		mult = 0.5
	owner.velocity = owner.direction * owner.speed * mult
#	host.move_and_slide(velocity)
#	tween.interpolate_property(host,"position", host.position, host.position + velocity, 0.2, Tween.TRANS_LINEAR,Tween.EASE_IN)
#	tween.start()
	owner.velocity = owner.move_and_slide(owner.velocity)

	if lean_on_move:
		if get_input_direction().x == Vector2.RIGHT.x:
			tween_rotation_degrees(lean_angle)
		elif get_input_direction().x == Vector2.LEFT.x:
			tween_rotation_degrees(-lean_angle)
		elif get_input_direction().x == 0:
			tween_rotation_degrees(0)

func enter():
	pass
#	if lean_on_move:
#		if get_input_direction() == Vector2.RIGHT:
#			tween_rotation_degrees(lean_angle)
#		if get_input_direction() == Vector2.LEFT:
#			tween_rotation_degrees(-lean_angle)

func exit():
	tween_rotation_degrees(0)

func tween_rotation_degrees(angle : int, duration := lean_duration):
	owner.tween.interpolate_property(owner.sprite_pivot,"rotation_degrees", owner.sprite_pivot.rotation_degrees, angle, duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	owner.tween.start()
