extends Node2D

var available_spawns = [] setget set_available_spawns

func _ready():
	update_available_spawns()

func update_available_spawns():
	for n in get_child_count():
		var child = get_child(n)
		if child is Position2D && child.is_available :
			available_spawns.append(child.position)
			set_available_spawns(available_spawns) #Weird hack to update global.available_spawns ...

func set_available_spawns(newvalue):
	available_spawns = newvalue
	global.available_spawns = newvalue