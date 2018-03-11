extends Node

#You can acces this class from every other. Just do global.VARIABLE, or global.METHOD()

var players_info = {}
var playerPos = Vector2(0,0)
var available_spawns = [] setget set_available_spawns, get_available_spawns

func set_available_spawns(value):
	available_spawns = value

func get_available_spawns():
	return available_spawns
	available_spawns.remove[0]