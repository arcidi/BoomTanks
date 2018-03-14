extends Node

var main_scene = null
var player_id #Id of the player

func _ready():
	main_scene = global.get_main_scene()



remote func spawn_player_car(player_id): #Spawn car for given player
	var car = preload("res://Scenes/PlayerTank.tscn").instance()
	car.set_name(str(player_id))
	car.set_network_master(player_id)
	car.position = global.available_spawns[0] #To fix, will cause error if there is no more available spawns
	global.available_spawns.remove(0) # This spawnPoint is taken!
	main_scene.get_node("Players").add_child(car)
	if player_id == get_tree().get_network_unique_id(): 
		car.get_node("Camera2D").current = true #If thats my car set his camera to current
		rpc("spawn_player_car", player_id)