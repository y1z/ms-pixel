class_name PixelCanvasSaver extends Object

enum SaveMode {
	SAVE_PNG,
	SAVE_JPG,
	SAVE_SIMPLE_PIXEL_FORMAT_TEXT,
	SAVE_SIMPLE_PIXEL_FORMAT_BINARY,
}


static func save(canvas:GdPixelCanvas, canvas_name:String, path:String, save_mode:SaveMode) -> bool:

	var print_error_info := func(error_value: Error) -> void:
		printerr("[ERR] : %s" % error_value);
		print("base directory = %s" % path);
		print("full directory = %s" % path + canvas_name);
		print("canvas name = %s" % canvas_name)

	match save_mode:
		SaveMode.SAVE_PNG:
			var err := canvas.raw_image.save_png(path + canvas_name)

			if OK != err:
				print_error_info.call(err);

			return true

		SaveMode.SAVE_JPG:
			var err := canvas.raw_image.save_png(path + canvas_name)

			if OK != err:
				print_error_info.call(err);

			return true

		SaveMode.SAVE_SIMPLE_PIXEL_FORMAT_TEXT:
			var saver:PixelCanvasSaveFormat = PixelCanvasSaveFormat.new()

			if OK != saver.save_as_text(canvas.raw_image, canvas_name, path):
				printerr("[ERR]: Saving failed")
				return false

		SaveMode.SAVE_SIMPLE_PIXEL_FORMAT_BINARY:
			var saver:PixelCanvasSaveFormat = PixelCanvasSaveFormat.new()

			if OK != saver.save_as_binary(canvas.raw_image, canvas_name, PixelCanvasGlobals.save_dir):
				printerr("[ERR]: Saving failed")
				return false

			return true

		_:
			printerr("CASE NOT HANDLED %s" % save_mode);

	return false


static func load(canvas:GdPixelCanvas, canvas_name:String) -> bool:
	var file := FileAccess.get_file_as_string(PixelCanvasGlobals.save_dir + canvas_name)

	var current_thing:= 0;

	var color_to_be_added: Color;
	while current_thing != -1:
		current_thing = file.findn(PixelCanvasSaveFormat.whole_color_separator, current_thing)
		var first_num_end := file.findn(PixelCanvasSaveFormat.individual_color_componet_separator, current_thing)
		color_to_be_added.r8 = file.substr(current_thing, first_num_end).to_int()
		current_thing = first_num_end

	var height_index := file.find("h:")

	return false


static func convert_to_num(input_num:String,index:int) -> int:
	const nums:= "0123456789";
	var is_valid_num := func(str_nums:String,input_num_:String,index_:int) -> int:
		var result := 0

		for n in nums:
			if n == input_num_[index_]:
				return result

		return -1

	var valid_num_index:int = is_valid_num.call(input_num,nums,index);
	var current_number = 1;
	var iteration := 0

	while valid_num_index != -1:
		current_number = (current_number * 10) + (int(nums[valid_num_index]) - int("0"))
		index = index + 1;

		valid_num_index = is_valid_num.call(input_num,nums,index);

	if iteration == 1:
		current_number = current_number / 10

	return current_number
