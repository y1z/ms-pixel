class_name GdPixelCanvas extends Node2D

const DEFAULT_WIDTH:int = 128
const DEFAULT_HEIGHT:int = 128
const DEFAULT_COLOR_BG:Color = Color.BLACK

var sprite: Sprite2D
var sprite_rect: Rect2
var texture: ImageTexture
var raw_image: Image
var format: Image.Format
var width: int
var height: int


func _ready() -> void:
	sprite = %Canvas
	UserData.draw_modes = UserData.DrawModes.NONE
	start();
	pass


func _process(_delta: float) -> void:
	if Input.is_action_pressed(InputNames.click_l):
		UserData.print_draw_mode()
		match UserData.draw_modes:
			UserData.DrawModes.NONE:
				put_pixel()
				return

			UserData.DrawModes.PUT_PIXEL:
				put_pixel()
				return

	if Input.is_action_just_released(InputNames.click_l):
		UserData.draw_modes = UserData.DrawModes.NONE

	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(InputNames.turn_on_debug):
		#turn_on_debug_things = !turn_on_debug_things
		pass

	if event.is_action_pressed(InputNames.change_size):
		if width == DEFAULT_WIDTH:
			print("change size 64")
			resize(64,64)
		else:
			print("change size else")
			resize(DEFAULT_WIDTH, DEFAULT_HEIGHT)

		pass

	pass


func start() -> void:
	format = Image.FORMAT_RGBA8
	raw_image = Image.create_empty(DEFAULT_WIDTH,DEFAULT_HEIGHT,false,format)
	texture = ImageTexture.create_from_image(raw_image)
	raw_image = color_entire_canvas(raw_image, DEFAULT_COLOR_BG);
	update_texture()
	sprite_rect = get_sprite_hitbox()
	pass


func update_texture() -> void:
	texture.update(raw_image)
	sprite.texture = texture


func resize(new_width: int, new_height:int) -> void:
	var new_image:Image = create_empty_image(new_width, new_height);

	new_image = color_entire_canvas(new_image, DEFAULT_COLOR_BG)
	new_image = copy_existing_image(new_image, raw_image)

	texture = ImageTexture.create_from_image(new_image)

	raw_image = new_image

	update_texture()
	sprite_rect = get_sprite_hitbox()
	width = new_image.get_width()
	print("current width = %s" % width)
	height = new_image.get_height()
	pass


func create_empty_image(new_width: int, new_height:int, new_format:Image.Format = Image.FORMAT_RGBA8) -> Image:

	if !PixelCanvasGlobals.accepted_formats.has(new_format):
			push_error("UNSUPPORTED FORMAT = %s" % str(new_format))
			return Image.create_empty(DEFAULT_WIDTH,DEFAULT_HEIGHT,false,Image.FORMAT_RGBA8)

	print_verbose("current format =[%s]" % PixelCanvasGlobals.accepted_formats[new_format])
	return Image.create_empty(new_width, new_height,false,new_format)


func give_default_pattern(image:Image) -> Image:
	var pattern_offset:int = 0
	const pattern_colors: Array[Color] = [Color.DIM_GRAY, Color.GRAY]

	for j in image.get_height():
		pattern_offset += 1;

		for i in image.get_width():
			var selected_color:int = (pattern_offset + i) % pattern_colors.size();
			image.set_pixel(i, j, pattern_colors[selected_color])

	return image;


func color_entire_canvas(image: Image, color: Color) -> Image:

	for i in image.get_width():
		for j in image.get_height():
			image.set_pixel(i,j,color);

	return image


func get_sprite_hitbox() -> Rect2:
	var sprite_size := Vector2(self.texture.get_width(),self.texture.get_height())
	return Rect2(sprite.get_rect().position,sprite_size) ;


func copy_existing_image(target:Image, src:Image, copy_within_limits:bool = true) -> Image:

	var limit_width:int = 0
	var limit_height:int = 0

	if copy_within_limits:
		limit_width = min(target.get_width(), src.get_width())
		limit_height = min(target.get_height(), src.get_height())
	else:
		limit_height = target.get_width()
		limit_width = target.get_height()

	for x in limit_width:
		for y in limit_height:
			target.set_pixel(x, y, src.get_pixel(x,y))

	return target


func draw_line_on_canvas(start_:Vector2i,end_:Vector2i) -> void:
	var delta := end_ - start_

	if delta.x == 0 && delta.y == 0:
		_only_draw_1_pixel()
		return

	if delta.x == 0 && abs(delta.y) > 0:
		var goes_up:bool = true if delta.y > 0 else false
		draw_vertical_line_on_canvas(start_, abs(delta.y), goes_up)
		return

	if abs(delta.x) > 0 && delta.y == 0:
		var goes_right: bool = true if delta.x > 0 else false
		draw_horizontal_line_on_canvas(start_, abs(delta.x), goes_right)
		return

	_simple_method(start_, end_)
	pass


## Gupta and Sproull algorithm
##@tutorial(link to wiki):https://en.wikipedia.org/wiki/Line_drawing_algorithm#Gupta_and_Sproull_algorithm
func _gupta_and_sproull_algo(start_:Vector2i, end_:Vector2i) -> void:
	var delta:Vector2i = end_ - start_;
	var discriminator := 2 * (delta.y - delta.x)
	var euclidean_distance := 0.0;
	pass


## Simple Method
func _simple_method(start_:Vector2i, end_:Vector2i) -> void:
	var delta := end_ - start_;
	var slope:float = float(delta.y) / float(delta.x)
	var difference_between_x:int = abs(delta.x)
	var minimum_x:int = min(end_.x, start_.x)
	var maximum_x:int = max(end_.x, start_.x)

	for x in range(minimum_x, maximum_x):
		var y_position := floori(slope * (x - start_.x) + start_.y)
		var position_before_correction := Vector2i(x, y_position);
		var is_inside_hitbox:bool = sprite_rect.has_point(position_before_correction)

		if !is_inside_hitbox: continue
		var corrected := Vector2(position_before_correction) - sprite_rect.position

		raw_image.set_pixel(corrected.x, corrected.y, UserData.current_color)

	update_texture()
	pass


func draw_vertical_line_on_canvas(start_:Vector2i, distance_:int, goes_up:bool) -> void:
	var current_position := start_;

	var increment:int = 1 if goes_up else -1;
	for i in distance_:
		var is_inside_hitbox:bool = sprite_rect.has_point(current_position)

		if !is_inside_hitbox: continue
		var final_pos := Vector2(current_position) - sprite_rect.position
		raw_image.set_pixelv(final_pos, UserData.current_color)
		current_position.y += increment

	update_texture()
	pass


func draw_horizontal_line_on_canvas(start_:Vector2i, distance_:int, goes_left_to_right:bool) -> void:
	var current_position := start_

	var increment:int = 1 if goes_left_to_right else -1;
	for i in distance_:
		var is_inside_hitbox:bool = sprite_rect.has_point(current_position)

		if !is_inside_hitbox: continue
		var final_pos := Vector2(current_position) - sprite_rect.position
		raw_image.set_pixelv(Vector2i(final_pos), UserData.current_color)
		current_position.x += increment

	update_texture()
	pass


func put_pixel() -> void:

	match UserData.draw_modes:
		UserData.DrawModes.NONE:
			UserData.start_point = get_local_mouse_position();
			_only_draw_1_pixel()
			UserData.draw_modes = UserData.DrawModes.PUT_PIXEL

		UserData.DrawModes.PUT_PIXEL:
			UserData.end_point = get_local_mouse_position()
			draw_line_on_canvas(UserData.start_point, UserData.end_point)
			UserData.start_point = UserData.end_point

		_:
			printerr("UN-HANDLED CASE %s " % UserData.keys()[UserData.draw_modes])

	pass


func _only_draw_1_pixel() -> void:
	var mouse_pos := get_local_mouse_position()# to_local(get_global_mouse_position())
	var is_inside_hitbox:bool = sprite_rect.has_point(mouse_pos)
	#print("is insde hitbox [%s]" % is_inside_hitbox)
	if !is_inside_hitbox: return
	var inside_sprite_pos:Vector2 = mouse_pos - sprite_rect.position
	@warning_ignore_start("narrowing_conversion")
	raw_image.set_pixel(inside_sprite_pos.x, inside_sprite_pos.y, UserData.current_color)
	@warning_ignore_restore("narrowing_conversion")
	texture.update(raw_image)
	sprite.texture = texture
	pass
