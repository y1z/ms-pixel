class_name PixelCanvasSaveFormat extends Object

#region configuration constants

const version:int = 1;
const extension:String = ".mysp"
const whole_color_separator:String = ","
const individual_color_componet_separator: String = " "

#endregion


func _init() -> void:
	assert(whole_color_separator != individual_color_componet_separator,"They need to be different")


func save_as_text(image: Image, name: String, save_path: String) -> Error:
	var image_width := image.get_width();
	var image_height := image.get_height();
	var data: String = "";

	for x in image_width:
		for y in image_height:
			var color:= image.get_pixel(x,y)

			data = data + _parse_color_data(color)
			pass

	#DirAccess.make_dir_absolute(save_path)
	var final_file: String = save_path

	print("save_path = %s" % save_path)

	if DirAccess.dir_exists_absolute(save_path):
		print("does exist")
		pass

	var file := FileAccess.open(final_file, FileAccess.WRITE_READ)

	if file == null:
		printerr(FileAccess.get_open_error())
		return FileAccess.get_open_error()

	var header:String = _build_header(image.get_format(), image_width, image_height, PixelCanvasGlobals.SavingFormats.TEXT);
	file.store_string(header)
	file.store_string(data)

	file.close()
	return OK


func save_as_binary(image: Image, name: String, save_path: String) -> Error:
	var header:String = _build_header(image.get_format(), image.get_width(), image.get_height(), PixelCanvasGlobals.SavingFormats.BINARY);
	return OK


## result -> the resulting string
## format -> the format in which the image is save
## width -> the width of the image
## height -> the height of the image
## _note -> Text that will be ignored during the loading process (also DON'T include newline characters aka \n or it breaks)
func _build_header(format: Image.Format, width:int, height:int, saving_formt:PixelCanvasGlobals.SavingFormats,_note:String = "") -> String:
	var has_valid_format:bool = PixelCanvasGlobals.accepted_formats.has(format)
	var result:String = "";

	if !has_valid_format:
		printerr("[ERR] Format not valid (format = %s)" % format)
		return result

	if width < 1:
		printerr("Can NOT have a width that is zero or less (width = %s)" % width)
		return result

	if height < 1:
		printerr("Can NOT have a height that is zero or less (height = %s)" % height)
		return result

	result = result + str("v:%s\n" % version)
	result = result + str("f:%s\n" % PixelCanvasGlobals.accepted_formats[format])
	result = result + str("w:%s\n" % width)
	result = result + str("h:%s\n" % height)
	result = result + str("t:%s\n" % PixelCanvasGlobals.SavingFormats.keys()[saving_formt])
	result = result + str("note:%s \n" % _note.c_unescape())

	return result


func _parse_color_data(color:Color) -> String:
	var separator:= individual_color_componet_separator;
	return whole_color_separator + str(color.r8) + separator + str(color.g8) + separator + str(color.b8) + separator + str(color.a8)
