extends "res://Scripts/Vehicle.gd"

var speed = 0
var velocity = Vector2(0,0)
var simulatedRotation
var new_player_input = false

func _ready():
	set_physics_process(true)
	maxSpeed = 600
	acceleration = 24000
	stering = 18000
	mass = 400
	traction = 100
	brakeForce = 400
	isAccelerating = false



func _physics_process(delta):
	if speed > maxSpeed: #Clamp funcion is probably doesn't work in this version of godot
		speed = maxSpeed
	elif speed < -maxSpeed:
		speed = -maxSpeed
	
	#Player input
	if is_network_master():
		new_player_input = false
		if Input.is_action_pressed("ui_up"):
			Accelerate(1, delta)
		elif Input.is_action_pressed("ui_down"):
			Accelerate(-1, delta)
		else: #slow vehicle down if not accelerate
			speed -= speed / mass 
		
		if Input.is_action_pressed("ui_left"):
			Turn(-1, delta)
		elif Input.is_action_pressed("ui_right"):
			Turn(1, delta)
		if new_player_input:#If there was new input, send this to players!
			rset("velocity", velocity) #Also, rset can couse big ping, if it does, experiment with rset_unreliable
	
	Rotate(delta)
	move_and_collide(velocity)
	rpc_unreliable("move_car", transform)

slave func move_car(trans):
	transform = trans

func Accelerate(acc_Axis, delta):
	new_player_input = true
	if acc_Axis < 0 && speed > 0: #If someone pressed back arrow, and his velocity is bigger than 0, start braking!
		Brake(delta)
	else:
		speed += (acceleration / mass) * acc_Axis * delta

func Turn(vector, delta): #Turn car in some direction
	new_player_input = true
	rotation_deg += (stering / (mass /2)) * inverse_lerp(maxSpeed, 1, speed) * vector * delta

func Brake(delta):
	speed -= (brakeForce / (mass / traction))  * delta

func Rotate(delta): #Change velocity vector according to rotation
	velocity = Vector2(sin(-rotation), cos(-rotation)) * speed * delta