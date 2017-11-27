extends Area2D

var velocity
var speed
var dmg
var owner


func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if get_tree().is_network_server():
		translate(velocity * speed * delta)
		rpc_unreliable("update_position", global_transform)

remote func update_position(trans):
	global_transform = trans

func _on_bulletBlue3_outline_body_entered( body ):
	if str(body.get_network_master()) != owner && body.is_in_group("Player"):
		queue_free()
