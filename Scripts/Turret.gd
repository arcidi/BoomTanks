extends Node2D



func _ready():
	set_process(true)

func _process(delta):
	if is_network_master():
		look_at(get_global_mouse_position())
		rpc_unreliable("set_rotation", rotation)
	

remote func set_rotation(rot):
	self.rotation = rot