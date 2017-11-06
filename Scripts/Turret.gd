extends Node2D

onready var bullet = load("res://Scenes/Turrets/Bullets/Bullet1.tscn")
onready var bulletSpawnPos = get_node("BulletSpawnPoint").global_position

var fireRate = 10
var fireCoolDown = float(0)

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	look_at(get_global_mouse_position())
	fireCoolDown -= delta
	if Input.is_action_pressed("Fire") and fireCoolDown < 0:
		SpawnBullet()
		fireCoolDown = float(1) / fireRate

func SpawnBullet():
	bulletSpawnPos = get_node("BulletSpawnPoint").global_position
	var bull = bullet.instance()
	get_parent().get_node("Bullet holder").add_child(bull)
	bull.position = bulletSpawnPos
	bull.velocity = bulletSpawnPos - global_position