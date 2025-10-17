extends Control

@export_category("VARIABLES")
@export var color: Color

var inner_panel: Panel


func _ready() -> void:
	inner_panel = %"inner panel"
	inner_panel.modulate = color
