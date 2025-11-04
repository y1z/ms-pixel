class_name PixelCanvasSaver extends Object

enum SaveMode {
	SAVE_PNG,
	SAVE_JPG,
	SAVE_SIMPLE_PIXEL_FORMAT
}

const save_dir:String = "user://saves/"


static func save(canvas:GdPixelCanvas, canvas_name:String, save_mode:SaveMode) -> bool:

	var print_error_info := func(error_value: Error) -> void:
		printerr("[ERR] : %s" % error_value);
		print("base directory = %s" % save_dir);
		print("full directory = %s" % save_dir + canvas_name);
		print("canvas name = %s" % canvas_name)

	match save_mode:
		SaveMode.SAVE_PNG:
			var err := canvas.raw_image.save_png(save_dir + canvas_name)

			if OK != err:
				print_error_info.call(err);

			return true

		SaveMode.SAVE_JPG:
			var err := canvas.raw_image.save_png(save_dir + canvas_name)

			if OK != err:
				print_error_info.call(err);

			return true

		SaveMode.SAVE_SIMPLE_PIXEL_FORMAT:
			var width := canvas.raw_image.get_width()
			var height := canvas.raw_image.get_height()
			var final_string : String = "";
			for x in width:
				for y in height:
					
			
			return true

		_:
			printerr("CASE NOT HANDLED %s" % save_mode);

	return false
