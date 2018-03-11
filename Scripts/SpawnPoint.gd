extends Position2D

var is_avaible = true

func _on_Area2D_body_entered( body ):
	if body.is_in_group("Player"):
		is_avaible = false


func _on_Area2D_body_exited( body ):
	if body.is_in_group("Player"):
		is_avaible = true
