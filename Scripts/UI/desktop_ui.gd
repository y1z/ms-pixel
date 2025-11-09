extends SceneUI


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

var current_draw_mode:UserData.DrawModes

var line_button:Button = Button.new();
var rect_button:Button = Button.new();

var file_buttons_container: VBoxContainer

var saving_dialog: FileDialog;
var loading_dialog: FileDialog


#region SceneUI Implementation
func start_the_ui(pix_canvas:GdPixelCanvas) -> void:
	file_and_panel = ButtonAndPanel.new()
	color_panel = ButtonAndPanel.new();
	image_panel = ButtonAndPanel.new();
	check_box = %CheckBox

	file_and_panel.start(%"file button",%"file button sub-menu")
	color_panel.start(%"color button", %"color button sub-menu")
	image_panel.start(%"image button", %"image  button sub-menu")

	line_button = %"Line Button"
	rect_button = %"Rect Button"

	desktop_color_picker = %"color picker"
	desktop_color_picker.visible = false
	check_box.toggled.connect(show_the_color_picker)
	connect_to_userdata(desktop_color_picker)
	current_draw_mode = UserData.draw_modes

	file_buttons_container = %file_menu_options

	saving_dialog = SceneUI.create_file_dialog(FileDialog.FileMode.FILE_MODE_SAVE_FILE)
	loading_dialog = SceneUI.create_file_dialog(FileDialog.FileMode.FILE_MODE_OPEN_FILE)

	self.add_child(saving_dialog)
	self.add_child(loading_dialog)
	saving_dialog.visible = false
	loading_dialog.visible = false
	saving_dialog.file_selected.connect(
		func(path:String):
			cb_on_file_selected(path, pix_canvas, false)

	)

	loading_dialog.file_selected.connect(
		func(path:String):
			cb_on_file_selected(path, pix_canvas, true)

	)
	for b in file_buttons_container.get_children():
		if b.name == "Save" && b is Button:
			var call_back:Callable = func()->void: saving_dialog.visible = true
			b.pressed.connect(
				func()->void:
				call_back.call()
				)

		if b.name == "Load" && b is Button:
			var call_back: Callable = func() ->void: loading_dialog.visible = true

	pass


func show_ui() -> void:
	pass


func hide_ui() -> void:
	pass


func show_the_color_picker(toggle_on:bool) -> void:
	desktop_color_picker.visible = toggle_on
	pass


func connect_to_userdata(color_picker: ColorPicker) -> void:
	UserData.connect_to_color_picker(color_picker)
	pass


func activate_tool(draw_mode_:UserData.DrawModes) -> void:
	match (draw_mode_):
		UserData.DrawModes.PUT_PIXEL:
			UserData.draw_modes = draw_mode_
			pass

		_:
			printerr("UN-HANDLED CASE REACHED")
			pass

	UserData.print_draw_mode()
	pass


func deactivate_tool(draw_mode_:UserData.DrawModes) -> void:
	match (draw_mode_):
		_:
			printerr("UN-HANDLED CASE REACHED")
			pass

	pass


func is_tool_active(draw_mode_:UserData.DrawModes) -> bool:
	return draw_mode_ == current_draw_mode


func open_saving_screen() -> void:
	pass


func open_loading_screen() -> void:
	pass

#endregion


func cb_on_file_selected(path:String, canvas:GdPixelCanvas, loading_file:bool) -> void:
	if !loading_file:
		PixelCanvasSaver.save(canvas, "", path,PixelCanvasSaver.SaveMode.SAVE_SIMPLE_PIXEL_FORMAT_TEXT)
	else:
		PixelCanvasSaver.load(canvas, path)

	pass
