class_name PixelCanvasSaveFormat extends Object

const version:int = 1;
const extention:String = ".mysp"

enum saving_formats {
	TEXT,
	BINARY
}


func save(image: Image, name: String, save_path: String) -> Error:
	var header:String = "";
	_build_header(header,image.get_format(),image.get_width(),image.get_height())
	return OK


## out -> the resulting string
## format -> the format in which the image is save
## width -> the width of the image
## height -> the height of the image
## _note -> Text that will be ignored during the loading process (also DON'T include newline characters aka \n or it breaks)
func _build_header(out:String, format: Image.Format, width:int, height:int,_note:String = "") -> String:
	var has_valid_format:bool = PixelCanvasGlobals.accepted_formats.has(format)

	if !has_valid_format:
		printerr("[ERR] Format not valid (format = %s)" % format)
		return out

	if width < 1:
		printerr("Can NOT have a width that is zero or less (width = %s)" % width)
		return out

	if height < 1:
		printerr("Can NOT have a height that is zero or less (height = %s)" % height)
		return out

	out = out + str("v:%s\n" % version)
	out = out + str("f:%s\n" % PixelCanvasGlobals.accepted_formats[format])
	out = out + str("w:%s\n" % width)
	out = out + str("h:%s\n" % height)
	out = out + str("note:%s \n" % _note.c_unescape())

	return out
