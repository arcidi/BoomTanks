extends Node2D

onready var bullet = load("res://Scenes/Turrets/Bullets/Bullet1.tscn")
onready var bulletSpawnPos = get_node("BulletSpawnPoint")



func _ready():
	set_process(true)

func _process(delta):
	look_at(get_global_mouse_position())
	print(rotation)

	if Input.is_action_pressed("Fire"):
		SpawnBullet(bullet)

func SpawnBullet(bullet):
	bulletSpawnPos = get_node("BulletSpawnPoint")
	var bull = bullet.instance()
	get_parent().get_node("Bullet holder").add_child(bull)
	bull.position = bulletSpawnPos.global_position
	bull.velocity = bulletSpawnPos.global_position - global_position