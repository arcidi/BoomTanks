extends "res://Scripts/Car.gd"

var backUp_Speed
var backUp_Velocity
var backUp_Rotation

var simulationAccuracy =1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _physics_process(delta):
	var simulatedNextMove = []
	BackUpVars()
	var x = float(-1)
	var closestPos = [-1, -1, position]
	
	#Accelerate(closestPos[0] *10, delta)
	#Turn(closestPos[1] * 10, delta)

func BackUpVars():
	backUp_Velocity = velocity
	backUp_Rotation = rotation_deg
	backUp_Speed = speed
func LoadBackUp():
	pass