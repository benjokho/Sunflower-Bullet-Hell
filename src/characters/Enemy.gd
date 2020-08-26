class_name Enemy
extends Character

onready var tween
onready var bullet_resource = preload("res://src/bullets/BulletLite.tscn")

onready var bullet_cd_timer = $Timers/BulletCD
onready var bullet_spawn_point = $Addons/BulletSpawner
onready var visibility = $Addons/VisibilityNotifier2D
onready var bullet_patterns = $Addons/BulletPatterns

func _ready():
	add_to_group("enemies")
	character_type = "enemy"
	change_direction()

func change_direction(dir = "idle"):
	sprite.play(dir)

func _physics_process(delta):
	._physics_process(delta)
	
	if _state.inputs.is_shooting and bullet_cd_timer.is_stopped():
		bullet_patterns.shoot()
		bullet_cd_timer.start()

func shoot():
	#checks bullet pool for free bullet
		var b = bullet_resource.instance()
		objects_holder.add_child(b)
		#REPLACE THIS ^
		
		#initializes that		
		b.setup(bullet_spawn_point.global_position, Vector2.DOWN, character_type)
		#REPLACE THIS ^
		
		#do CD
		bullet_cd_timer.start()

func in_position():
	return false

func damage(dmg = 1):
	if visibility.is_on_screen():
		.damage()


func _on_VisibilityNotifier2D_screen_exited():
	position.y = -100
