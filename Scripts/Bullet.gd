extends KinematicBody2D

var dmg 
var mass
var velocity = Vector2(0,0)

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	move_and_collide(velocity)