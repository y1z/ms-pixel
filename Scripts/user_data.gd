extends Node
# UserData

enum DrawModes {NONE = 0,
PUT_PIXEL = 1,
LINES,
RECTANGLES,
CIRCLES,
}

var current_color: Color
var draw_modes: DrawModes = DrawModes.NONE

var start_point: Vector2i
var end_point: Vector2i

var connected_color_picker: ColorPicker = null


func _ready() -> void:
	current_color = Color(1,1,1,1.0);
	draw_modes = DrawModes.PUT_PIXEL
	print_draw_mode()


func print_draw_mode() ->void:
	print_rich("[b]",DrawModes.find_key(draw_modes),"[/b]")


func set_draw_mode(new_draw_mode: DrawModes) -> void:
	draw_modes = new_draw_mode;


func connect_to_color_picker(color_picker: ColorPicker) -> void:
	connected_color_picker = color_picker
	color_picker.color_changed.connect(cb_on_color_picker_change)
	pass


func cb_on_color_picker_change(color: Color) -> void:
	current_color = color
	pass
