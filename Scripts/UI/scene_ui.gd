@abstract class_name SceneUI extends Control


@abstract func start_the_ui(pix_canvas:GdPixelCanvas) -> void


@abstract func show_ui() -> void


@abstract func hide_ui() -> void


@abstract func activate_tool(draw_mode:UserData.DrawModes) -> void


@abstract func deactivate_tool(draw_mode:UserData.DrawModes) -> void


@abstract func is_tool_active(draw_mode:UserData.DrawModes) -> bool


@abstract func open_saving_screen() -> void


@abstract func open_loading_screen() -> void


static func create_file_dialog(file_mode: FileDialog.FileMode, window_mode:Window.Mode = Window.Mode.MODE_WINDOWED) -> FileDialog:
	var result := FileDialog.new()
	result.mode = window_mode
	result.access = FileDialog.ACCESS_FILESYSTEM
	result.file_mode = file_mode
	##@tutorial(what the strings are suppost to be): https://docs.godotengine.org/en/stable/classes/class_filedialog.html#class-filedialog-property-filters
	var file_filters_first_half: String = "*%s;save_data " % PixelCanvasSaveFormat.extension
	var file_filters_second_half: String = "Files;save_data/%s" % PixelCanvasSaveFormat.extension
	result.filters = [file_filters_first_half + file_filters_second_half ]
	return result
