extends Node2D

onready var bullet_scene = preload("res://Scenes/bulletBlue3_outline.tscn")

var shoot_per_seconds = 1
sync var cool_down_timer = float(1) / shoot_per_seconds

func _ready():
	set_process(true)

func _process(delta):
	cool_down_timer -= delta
	if is_network_master():
		look_at(get_global_mouse_position())
		rpc_unreliable("set_rotation", rotation)
		if Input.is_action_pressed("Fire") && cool_down_timer <= 0:
			rpc("spawn_bullet")

remote func set_rotation(rot):
	self.rotation = rot

sync func spawn_bullet():
	if cool_down_timer <= 0: 
		var bullet = bullet_scene.instance()
		if get_tree().is_network_server():
			bullet.rotation_degrees = global_rotation_degrees + 90
			bullet.velocity = Vector2(1,0).rotated(global_rotation)
			bullet.speed = 500
		bullet.position = get_node("BulletSpawnPoint").global_position
		bullet.dmg = 25 # REPLACE IT!!!
		bullet.master_of_bullet = get_parent().get_name()
		cool_down_timer = float(1) / shoot_per_seconds
		get_tree().get_root().add_child(bullet)