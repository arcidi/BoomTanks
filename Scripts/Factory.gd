extends Node

func  LoadBody(index):
	return get_child(index).duplicate()

func GetBodyName(index):
	return get_child(index).get_name()

