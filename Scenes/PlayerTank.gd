extends KinematicBody2D

#Todo
#Moevement
#Input - player sends only float betwen -1 to 1 via rpc
#Server sends rpc_unreliable position


var velocity = Vector2(0,1)
var rotation_speed = 1;


sync var is_left_pressed = false
sync var is_right_pressed = false
sync var is_acc_pressed = false
sync var is_brake_pressed = false

func _ready():
	set_physics_process(true)
	set_process_input(true)

func _physics_process(delta):
	
	
	move_and_collide(velocity.rotated(rotation))


func _input(event):
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