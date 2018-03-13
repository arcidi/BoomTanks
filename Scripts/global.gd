extends Node

#You can acces this class from every other. Just do global.VARIABLE, or global.METHOD()

var players_info = {}
var playerPos = Vector2(0,0)
var available_spawns = [] 


func get_main_scene():
	var root = get_tree().get_root()
	return root.get_child( root.get_child_count() -1 ) 