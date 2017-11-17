extends "res://Scripts/Vehicle.gd"

#To do:
#Rewrite script, its made for cars, not tanks!



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
	clamp(speed, -maxSpeed, maxSpeed)
	
	#Player input
	if is_network_master():
		new_player_input = false
		if Input.is_action_pressed("ui_up"):
			rpc("Accelerate", 1, delta)
		if Input.is_action_pressed("ui_down"):
			rpc("Accelerate", -1, delta)
		
		 #slow vehicle down
		speed -= speed / mass 
		
		if Input.is_action_pressed("ui_left"):
			rpc("Turn", -1, delta)
		if Input.is_action_pressed("ui_right"):
			rpc("Turn", 1, delta)
	
	Rotate(delta)
	move_and_collide(velocity)



sync func Accelerate(acc_Axis, delta):
	new_player_input = true
	acc_Axis = clamp(acc_Axis, -1, 1) #Make sure that player don't try to cheat!
	if acc_Axis < 0 && speed > 0: #If someone pressed back arrow, and his velocity is bigger than 0, start braking!
		Brake(delta)
	else:
		speed += (acceleration / mass) * acc_Axis * delta

sync func Turn(vector, delta): #Turn car in some direction
	vector =  clamp(vector, -1, 1) #Make sure that player don't try to cheat!
	new_player_input = true
	rotation_deg += (stering / (mass /2)) * vector * delta

func Brake(delta):
	speed -= (brakeForce / (mass / traction))  * delta

func Rotate(delta): #Change velocity vector according to rotation
	velocity = Vector2(sin(-rotation), cos(-rotation)) * speed * delta