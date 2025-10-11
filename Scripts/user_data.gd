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


func _ready() -> void:
	current_color = Color(1,1,1,1.0);
	draw_modes = DrawModes.PUT_PIXEL
	print_draw_mode()


func print_draw_mode() ->void:
	print_rich("[b]",DrawModes.find_key(draw_modes),"[/b]")


func set_draw_mode(new_draw_mode:DrawModes) -> void:
	draw_modes = new_draw_mode;
