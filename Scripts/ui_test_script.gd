extends Control
class_name SceneUILUL

@export_group("VARIABLES")
@export var color_picker: ColorPicker


func _ready() -> void:
	OS.get_name()
	color_picker = %"color picker"
	color_picker.visible = false


func get_current_color() -> Color:
	return color_picker.color
