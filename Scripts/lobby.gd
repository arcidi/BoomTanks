extends Control

#To do:
# This code is half copy-paste from bomber example, probably need some refactor
# More comments!

var slots = 4
const port = 8910 #Random port, probalby needs change
var my_info = { name = "ServerGuy", id = 1}

func _player_disconnected(id):
	global.players_info.erase(id) #remove player id from list
	rpc("update_players_list") 
	if get_tree().is_network_server(): #Rpc don't send signal to server... So if im server, i need update this list too!
		update_player_list()

func _server_disconnected():
	global.players_info.clear()
	update_player_list()
	_set_status("Server disconnected", false)

func _player_connected(id):
	pass

func _connected_fail():
	_set_status("Couldn't connect",false)
	get_tree().set_network_peer(null) #remove peer

func _connected_ok():
	my_info.id = get_tree().get_network_unique_id()
	rpc("register_player", my_info.id, my_info)
	_set_status("connected!", true)
	

func _set_status(text,isok):
	#simple way to show status
	if (isok):
		get_node("panel/status_ok").set_text(text)
		get_node("panel/status_fail").set_text("")
	else:
		get_node("panel/status_ok").set_text("")
		get_node("panel/status_fail").set_text(text)


func _on_host_pressed():
	var host = NetworkedMultiplayerENet.new()
	host.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_RANGE_CODER)
	var err = host.create_server(port, slots)
	if(err != OK):
		_set_status("Can't host, address in use.", false)
		return
	get_tree().set_network_peer(host)
	get_node("panel/join").set_disabled(true)
	get_node("panel/host").set_disabled(true)
	_set_status("Waiting for player...", true)
	my_info.name = get_node("panel/name").get_text()
	global.players_info[1] = my_info # Add server to players list!


func _on_join_pressed():
	var ip = get_node("panel/address").get_text()
	if (not ip.is_valid_ip_address()):
		_set_status("IP address is invalid",false)
		return
	
	var host = NetworkedMultiplayerENet.new()
	host.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_RANGE_CODER)
	host.create_client(ip,port)
	get_tree().set_network_peer(host)
	
	my_info.name = get_node("panel/name").get_text()
	_set_status("Connecting..",true)
	
	#If reconnect, update player list
	update_player_list() 
	global.players_info.clear()

func _on_start_pressed():
	hide()
	if get_tree().is_network_server():
		rpc("spawn_players")
		spawn_players()

remote func spawn_players():
	#var myCar = preload("res://Scenes/PlayerCar.tscn").instance()
	#myCar.set_name(str(get_tree().get_network_unique_id()))
	#myCar.set_network_master(get_tree().get_network_unique_id())
	#get_parent().get_parent().get_node("Players").add_child(myCar)
	#get_node("/Players").add_child(car)
	var x = 0
	for cars in global.players_info:
		x += 1
		var car = preload("res://Scenes/PlayerCar.tscn").instance()
		car.set_name(str(cars))
		car.set_network_master(cars)
		car.position += Vector2(50, 0) * x
		get_parent().get_parent().get_node("Players").add_child(car)

remote func register_player(id, info):
	# Store the info
	global.players_info[id] = info
	# If I'm the server, let the new guy know about existing players
	if (get_tree().is_network_server()):
		# Send my info to new player
		rpc_id(id, "register_player", 1, my_info)
		update_player_list() #Update player list on server client
		
		
		# Send the info of existing players
		for peer_id in global.players_info:
			rpc_id(id, "register_player", peer_id, global.players_info[peer_id])
		rpc("update_player_list") #Update player list for all players
	# Call function to update lobby UI here

remote func update_player_list():
	var players_list = []
	for p in range(get_node("list/players").get_child_count()):
		#If player don't exist in player_info but exist in player list, remove it!
		var player = get_node("list/players").get_child(p)
		if !global.players_info.has(player.get_name()):
			player.queue_free()
		else: players_list.append(player.get_name()) #Player exist, add his id to array!
	for peer_id in global.players_info:
		if !players_list.has(peer_id): #if player exist in player info, but don't in player_list, add him to list!
			var lab = Label.new()
			lab.text = global.players_info[peer_id].name
			lab.set_name(str(global.players_info[peer_id].id))
			get_node("list/players").add_child(lab)

func _ready():
	# connect all the callbacks related to networking
	get_tree().connect("network_peer_connected",self,"_player_connected")
	get_tree().connect("network_peer_disconnected",self,"_player_disconnected")
	get_tree().connect("connected_to_server",self,"_connected_ok")
	get_tree().connect("connection_failed",self,"_connected_fail")
	get_tree().connect("server_disconnected",self,"_server_disconnected")











