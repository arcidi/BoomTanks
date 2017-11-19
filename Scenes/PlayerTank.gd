extends KinematicBody2D

#Todo
#Moevement
#Input - player sends only float betwen -1 to 1 via rpc
#Server sends rpc_unreliable position


var velocity = Vector2(0,0)
var rotation_speed = 2
var max_velocity = 3
var acceleration = 2

sync var is_left_pressed = false
sync var is_right_pressed = false
sync var is_acc_pressed = false
sync var is_brake_pressed = false

func _ready():
	set_physics_process(true)
	set_process_input(true)

func _physics_process(delta):
	#procces input
	if is_left_pressed || is_right_pressed:
		if is_left_pressed:
			rotation -= clamp(velocity.y, rotation_speed, max_velocity) * delta
			if velocity.y > max_velocity * 0.7:
				brake(0.6, delta)
		if is_right_pressed:
			rotation += clamp(velocity.y, rotation_speed, max_velocity) * delta
			if velocity.y > max_velocity * 0.7:
				brake(0.6, delta)
	if is_acc_pressed || is_brake_pressed:
		if is_acc_pressed:
			velocity.y += acceleration * delta
		if is_brake_pressed:
			velocity.y -= acceleration * delta
	else: brake(1, delta)
	
	velocity = Vector2(0, clamp(velocity.y, -max_velocity, max_velocity))
	move_and_collide(velocity.rotated(rotation))
	
	if get_tree().is_network_server(): #If someone lost connection, then he will have this from server.
		rset_unreliable("transform", transform)
		rset_unreliable("velocity", velocity)

func brake(force, delta):
	velocity.y -= velocity.y * (delta * force) 
	if (velocity.y < 0.03 && velocity.y > 0) || (velocity.y > -0.03 && velocity.y < 0) :
		velocity.y = 0

func _input(event):
	if is_network_master():
		if event.is_action_pressed("ui_up"):
			rset("is_acc_pressed", true)
		if event.is_action_released("ui_up"):
			rset("is_acc_pressed", false)
		
		if event.is_action_pressed("ui_down"):
			rset("is_brake_pressed", true)
		if event.is_action_released("ui_down"):
			rset("is_brake_pressed", false)
		
		if event.is_action_pressed("ui_left"):
			rset("is_left_pressed", true)
		if event.is_action_released("ui_left"):
			rset("is_left_pressed", false)
			
		if event.is_action_pressed("ui_right"):
			rset("is_right_pressed", true)
		if event.is_action_released("ui_right"):
			rset("is_right_pressed", false)