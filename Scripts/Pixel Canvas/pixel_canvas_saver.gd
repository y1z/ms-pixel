class_name PixelCanvasSaver extends Object

enum SaveMode {
	SAVE_PNG,
	SAVE_JPG,
	SAVE_SIMPLE_PIXEL_FORMAT
}



static func save(canvas:GdPixelCanvas, canvas_name:String, save_mode:SaveMode) -> bool:

	var print_error_info := func(error_value: Error) -> void:
		printerr("[ERR] : %s" % error_value);
		print("base directory = %s" % PixelCanvasGlobals.save_dir);
		print("full directory = %s" % PixelCanvasGlobals.save_dir + canvas_name);
		print("canvas name = %s" % canvas_name)

	match save_mode:
		SaveMode.SAVE_PNG:
			var err := canvas.raw_image.save_png(PixelCanvasGlobals.save_dir + canvas_name)

			if OK != err:
				print_error_info.call(err);

			return true

		SaveMode.SAVE_JPG:
			var err := canvas.raw_image.save_png(PixelCanvasGlobals.save_dir + canvas_name)

			if OK != err:
				print_error_info.call(err);

			return true

		SaveMode.SAVE_SIMPLE_PIXEL_FORMAT:
			var saver:PixelCanvasSaveFormat = PixelCanvasSaveFormat.new()
			
			saver.save(canvas.raw_image,canvas_name,PixelCanvasGlobals.save_dir)

			return true

		_:
			printerr("CASE NOT HANDLED %s" % save_mode);

	return false
