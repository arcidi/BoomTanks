extends KinematicBody2D

#Todo
#Moevement
#Input - player sends only float betwen -1 to 1 via rpc
#Server sends rpc_unreliable position

var velocity = Vector2(0,0)



func _ready():
	set_physics_process(true)

func _physics_process(delta):
	
	#Change velocity vector according to rotation
	velocity = Vector2(sin(-rotation), cos(-rotation)) * speed * delta
	
	move_and_collide(velocity)
	
	pass