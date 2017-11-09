extends "res://Scripts/Car.gd"

func _ready():
	set_physics_process(true)

slave func move_car(trans):
	transform = trans

func _physics_process(delta):
	var turn = 0
	var acc = 0
	if is_network_master():
		#global.playerPos = position
		if Input.is_action_pressed("ui_up"):
			acc = 1
		elif Input.is_action_pressed("ui_down"):
			acc = -1
		if Input.is_action_pressed("ui_left"):
			turn = -1
		elif Input.is_action_pressed("ui_right"):
			turn = 1
		
		Accelerate(acc, delta)
		Turn(turn, delta)
		rpc_unreliable("move_car", transform)