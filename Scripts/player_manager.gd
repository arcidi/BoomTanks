extends Node

var main_scene = null


func _ready():
	var root = get_tree().get_root()
	main_scene = root.get_child( root.get_child_count() -1 ) 

func spawn_player_car(player_id):
		var car = preload("res://Scenes/PlayerTank.tscn").instance()
		car.set_name(str(player_id))
		car.set_network_master(player_id)
		car.position = global.available_spawns[0] #To fix, will cause error if there is no more available spawns
		main_scene.get_node("Players").add_child(car)
		if player_id == get_tree().get_network_unique_id(): 
			car.get_node("Camera2D").current = true #If thats my car set his camera to current