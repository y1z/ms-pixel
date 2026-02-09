extends Node

# UserData

enum DrawModes {
	NONE = 0,
	PUT_PIXEL = 1,
	LINES,
	RECTANGLES,
	CIRCLES,
}

var current_color: Color
var draw_modes: DrawModes = DrawModes.NONE:
	set(new_draw_mode):
		draw_modes = new_draw_mode
		print_draw_mode()

	get:
		return draw_modes

var selected_canvas: GdPixelCanvas

var start_point: Vector2i
var end_point: Vector2i

var connected_color_picker: ColorPicker = null


func _ready() -> void:
	current_color = Color(1, 1, 1, 1.0);
	draw_modes = DrawModes.PUT_PIXEL
	print_draw_mode()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		notifcation_disconnect()
		get_tree().quit()


func notifcation_disconnect() -> void:
	if connected_color_picker != null:
		disconnect_to_color_picker(connected_color_picker)

	pass


func print_draw_mode() -> void:
	print_rich("[b]", DrawModes.find_key(draw_modes), "[/b]")


func set_draw_mode(new_draw_mode: DrawModes) -> void:
	draw_modes = new_draw_mode;


func connect_to_color_picker(color_picker: ColorPicker) -> void:
	connected_color_picker = color_picker
	color_picker.color_changed.connect(cb_on_color_picker_change)
	pass


func disconnect_to_color_picker(color_picker: ColorPicker) -> void:
	if connected_color_picker != color_picker:
		push_error("TRYING to disconnect color picker that is not connected")
		return

	connected_color_picker = null
	color_picker.color_changed.disconnect(cb_on_color_picker_change)
	pass


func cb_on_color_picker_change(color: Color) -> void:
	current_color = color
	pass
