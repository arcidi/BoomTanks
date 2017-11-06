extends KinematicBody2D

var maxSpeed = 600
var speed = 0
var acceleration = 400
var velocity = Vector2(0,0)
var stering = 180
var mass = 100


func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		speed += (acceleration - mass) * delta
	elif Input.is_action_pressed("ui_down"):
		speed -= (acceleration - mass) * delta
	else:
		speed -= speed / mass#slow vehicle down if not accelerate
	if Input.is_action_pressed("ui_left"):
		rotation_deg -= (stering - (mass /2)) * inverse_lerp(0, maxSpeed, speed) * delta 
	if Input.is_action_pressed("ui_right"):
		rotation_deg += (stering - (mass /2)) * inverse_lerp(0, maxSpeed, speed) * delta
	
	#Clamp doesn't work? Well this is still alfa...
	if speed > maxSpeed: 
		speed = maxSpeed
	elif speed < -maxSpeed:
		speed = -maxSpeed
	
	velocity = Vector2(sin(-rotation), cos(-rotation)) * speed * delta #Change velocity vector according to rotation
	move_and_collide(velocity)
	
