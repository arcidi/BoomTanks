extends Control

var projectResolution = Vector2(ProjectSettings.get("display/window/size/width"),ProjectSettings.get("display/window/size/height"))
onready var vehicleViewPanel = get_node("VehicleView Panel")
onready var itemSelectPanel = get_node("ItemSelect Panel")
onready var statsPanel = get_node("Stats Panel")
onready var buttonPanel = get_node("ButtonPanel")

var x = 30

func _ready():
	ResizeControlNodes()
	set_process(true)

func _process(delta):
	ResizeControlNodes()

func ResizeControlNodes(): 
	projectResolution = get_viewport_rect().size
	buttonPanel.rect_size = Vector2(projectResolution.y / 5, projectResolution.y)
	itemSelectPanel.rect_size = Vector2(projectResolution.x / 8, projectResolution.y)
	itemSelectPanel.rect_position = Vector2(buttonPanel.rect_size.x,0)
	
	vehicleViewPanel.rect_size = Vector2(projectResolution.x - buttonPanel.rect_size.x + buttonPanel.rect_size.x, projectResolution.y * (float(6)/10))
	vehicleViewPanel.rect_position = Vector2(buttonPanel.rect_size.x + itemSelectPanel.rect_size.x ,0)
	
	statsPanel.rect_size = Vector2(projectResolution.x - buttonPanel.rect_size.x + buttonPanel.rect_size.x, projectResolution.y * (float(6)/10))
	vehicleViewPanel.rect_position = Vector2(buttonPanel.rect_size.x + itemSelectPanel.rect_size.x , vehicleViewPanel.rect_size.y)
	