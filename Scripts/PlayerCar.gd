extends "res://Scripts/Car.gd"

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		Accelerate(1, delta)
	elif Input.is_action_pressed("ui_down"):
		Accelerate(-1, delta)
	if Input.is_action_pressed("ui_left"):
		Turn(-1, delta)
	elif Input.is_action_pressed("ui_right"):
		Turn(1, delta)