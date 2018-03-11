extends Position2D

var is_available = true
signal is_available_changed

func _ready():
	
	connect("is_available_changed", get_parent(), "update_available_spawns")

func _on_Area2D_body_entered( body ):
	if body.is_in_group("Player"):
		is_available = false
		emit_signal("is_available_changed")


func _on_Area2D_body_exited( body ):
	if body.is_in_group("Player"):
		is_available = true
		emit_signal("is_available_changed")
