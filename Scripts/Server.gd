extends Node

func _ready():
	get_node("Main/Control/lobby")._on_host_pressed()