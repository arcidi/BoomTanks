extends KinematicBody2D

var velocity
var speed
var dmg


func _ready():
	set_physics_process(true)

func _physics_process(delta):
	
	if get_tree().is_network_server():
		var collision_object = move_and_collide(velocity * speed * delta)
		rpc_unreliable("update_position", position)
		print(collision_object.get_name())

remote func update_position(pos):
	position = pos