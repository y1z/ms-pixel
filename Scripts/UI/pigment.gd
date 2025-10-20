extends Control

@export_category("VARIABLES")
@export var color: Color

var inner_panel: Panel


func _ready() -> void:
	inner_panel = %"inner panel"
	inner_panel.add_theme_color_override("bg_color", Color.WHITE)
	print(inner_panel.get_theme_color("bg_color"))
	inner_panel.modulate = color
	print(inner_panel.get_theme_color("bg_color"))


func _input(event: InputEvent) -> void:

	if event.is_action_pressed(InputNames.click_l):
		var mouse_pos := (get_global_mouse_position())
		#print("mouse pos = %s" % mouse_pos)
		#print("innter_panel rect = %s" % inner_panel.get_global_rect())

		if inner_panel.get_global_rect().has_point(mouse_pos):
			print("color = %s" % color)
			print_rich("[b]INSIDE THING BOI[/b]")
			UserData.current_color = color

	pass
