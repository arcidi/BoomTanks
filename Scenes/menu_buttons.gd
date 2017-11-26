extends TextureButton

func _on_host_button_down():
	get_tree().change_scene("res://Scenes/host.tscn")
	

func _on_join_button_down():
	get_tree().change_scene("res://Scenes/join.tscn")

func _on_options_button_down():
	get_tree().change_scene("res://Scenes/options.tscn")
