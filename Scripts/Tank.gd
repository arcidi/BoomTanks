extends KinematicBody2D

var maxSpeed = 15000
var speed = 0
var acceleration = 300
var mass
var velocity = Vector2(0,0)


func _ready():
	set_physics_process(true)

func _physics_process(delta):
	print(rotation_deg)
	
	if Input.is_action_pressed("ui_up"):
		speed += acceleration
	if Input.is_action_pressed("ui_down"):
		speed -= acceleration
	if Input.is_action_pressed("ui_left"):
		rotation_deg -= 180 * delta
	if Input.is_action_pressed("ui_right"):
		rotation_deg += 180 * delta
	if(speed > maxSpeed):
		speed = maxSpeed
	velocity = Vector2(sin(-rotation), cos(-rotation)) * speed * delta
	move_and_slide(velocity)
	speed -= speed / 100
