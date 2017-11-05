extends KinematicBody2D

var maxSpeed = 350
var speed = 0
var acceleration = 150
var velocity = Vector2(0,0)
var stering = 180


func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		speed += acceleration * delta
	elif Input.is_action_pressed("ui_down"):
		speed -= acceleration * delta
	else:
		speed -= speed / 30
	if Input.is_action_pressed("ui_left"):
		rotation_deg -= stering * inverse_lerp(0, maxSpeed, speed) * delta 
	if Input.is_action_pressed("ui_right"):
		rotation_deg += stering * inverse_lerp(0, maxSpeed, speed) * delta
	
	#Clamp doesn't work? Well this is still alfa...
	if speed > maxSpeed: 
		speed = maxSpeed
	elif speed < -maxSpeed:
		speed = -maxSpeed
	
	velocity = Vector2(sin(-rotation), cos(-rotation)) * speed * delta #Change velocity vector according to rotation
	move_and_collide(velocity)
	
