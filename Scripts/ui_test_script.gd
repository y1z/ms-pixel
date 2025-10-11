extends Control
class_name SceneUI

@export_group("VARIABLES")
@export var color_picker: ColorPicker


func _ready() -> void:
	OS.get_name()
	color_picker = %"color picker"


func get_current_color() -> Color:
	return color_picker.color
