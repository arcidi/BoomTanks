extends "res://Scripts/Vehicle.gd"

var speed = 0
var velocity = Vector2(0,0)
var simulatedRotation


func _ready():
	set_physics_process(true)
	maxSpeed = 600
	acceleration = 400
	stering = 180
	mass = 100
	traction = 100
	brakeForce = 400
	isAccelerating = false



func _physics_process(delta):
	#Clamp doesn't work? Well this is still alfa...
	if speed > maxSpeed:
		speed = maxSpeed
	elif speed < -maxSpeed:
		speed = -maxSpeed
	if !isAccelerating:
		speed -= speed / mass #slow vehicle down if not accelerate
	Rotate(delta)
	move_and_collide(velocity)
	isAccelerating = false

func Accelerate(vector, delta):
	if vector == -1 && speed > 0:
		Brake(delta)
		isAccelerating = false
	else:
		speed += (acceleration - mass) * vector * delta
		isAccelerating = true

func Turn(vector, delta): #Turn car in some direction
	rotation_deg += (stering - (mass /2)) * inverse_lerp(0, maxSpeed, speed) * vector * delta

func Brake(delta):
	speed -= (brakeForce - (mass / traction))  * delta

func Rotate(delta): #Change velocity vector according to rotation
	velocity = Vector2(sin(-rotation), cos(-rotation)) * speed * delta