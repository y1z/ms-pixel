extends Control


class ButtonAndPanel:
	var button:Button
	var panel: Panel


	func start(_button: Button, _panel: Panel, on_button_pressed_func: Callable = cb_default_on_pressed) ->void:
		button = _button;
		panel = _panel
		button.pressed.connect(on_button_pressed_func)
		panel.visible = false


	func cb_default_on_pressed() ->void:
		panel.visible = !panel.visible

var file_and_panel: ButtonAndPanel;
var color_panel: ButtonAndPanel;
var image_panel: ButtonAndPanel;

var check_box: CheckBox

var desktop_color_picker: ColorPicker


func _ready() -> void:
	file_and_panel = ButtonAndPanel.new()
	color_panel = ButtonAndPanel.new();
	image_panel = ButtonAndPanel.new();
	check_box = %CheckBox

	file_and_panel.start(%"file button",%"file button sub-menu")
	color_panel.start(%"color button", %"color button sub-menu")
	image_panel.start(%"image button", %"image  button sub-menu")

	desktop_color_picker = %"color picker"
	desktop_color_picker.visible = false
	check_box.toggled.connect(show_the_color_picker)
	connect_to_userdata(desktop_color_picker)


func show_the_color_picker(toggle_on:bool) -> void:
	desktop_color_picker.visible = toggle_on
	pass


func connect_to_userdata(color_picker: ColorPicker) -> void:
	UserData.connect_to_color_picker(color_picker)
	pass
