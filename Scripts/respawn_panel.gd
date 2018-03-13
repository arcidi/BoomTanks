extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"




func _on_respawn_btn_pressed():
	player_manager.spawn_player_car(get_tree().get_network_unique_id())
	visible = false
