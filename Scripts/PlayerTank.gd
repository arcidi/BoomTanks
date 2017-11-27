extends KinematicBody2D

#Todo
#Moevement
#Input - player sends only float betwen -1 to 1 via rpc
#Server sends rpc_unreliable position


sync var velocity = Vector2(0,0)
var rotation_speed = 2
var max_velocity = 3
var acceleration = 2
var hp = 100

sync var is_left_pressed = false
sync var is_right_pressed = false
sync var is_acc_pressed = false
sync var is_brake_pressed = false

func _ready():
	set_process(true)
	set_physics_process(true)
	set_process_input(true)

func _process(delta):
	if get_tree().is_network_server(): #Im the server, my send this car transform to all!
		rpc_unreliable("set_position_and_rotation", position, rotation)
		rset_unreliable("velocity", velocity)
		if hp <= 0:
			rpc("destroy")

slave func destroy():
	#print("Im destroyed!" + get_name())
	pass

func _physics_process(delta):
	#procces input
	if is_left_pressed || is_right_pressed:
		if is_left_pressed:
			rotation -= clamp(velocity.y, rotation_speed, max_velocity) * delta
			if velocity.y > max_velocity * 0.7:
				brake(5, delta)
		if is_right_pressed:
			rotation += clamp(velocity.y, rotation_speed, max_velocity) * delta
			if velocity.y > max_velocity * 0.7:
				brake(5, delta)
		if !is_acc_pressed && !is_brake_pressed:
			brake(2, delta)
	elif is_acc_pressed || is_brake_pressed:
		if is_acc_pressed:
			velocity.y += acceleration * delta
		if is_brake_pressed:
			velocity.y -= acceleration * delta
	else: brake(2, delta)
	
	
	
	velocity = Vector2(0, clamp(velocity.y, -max_velocity, max_velocity))
	move_and_collide(velocity.rotated(rotation))
	

remote func set_position_and_rotation(pos, rot):
	position = pos
	rotation = rot

func brake(force, delta):
	velocity.y -= velocity.y * force * ease(inverse_lerp(max_velocity + 0.01, 0, velocity.y), 0.3) * delta 
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