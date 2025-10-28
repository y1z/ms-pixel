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

const accepted_formats: Dictionary = {
	Image.FORMAT_RGBA8: "Image.FORMAT_RGBA8",
	Image.FORMAT_RGB8: "Image.FORMAT_RGB8",
	}


func _ready() -> void:
	sprite = %Canvas
	start();
	pass


func _process(delta: float) -> void:
	if Input.is_action_pressed(InputNames.click_l):
		var mouse_pos := to_local(get_global_mouse_position())
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


func _input(event: InputEvent) -> void:
	if event.is_action(InputNames.click_l):
		var mouse_pos := to_local(get_global_mouse_position())
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
	texture.update(raw_image)
	sprite.texture = texture
	sprite_rect = get_sprite_hitbox()
	pass


func resize(new_width: int, new_height:int) -> void:
	var new_image:Image = create_empty_image(new_width, new_height);

	new_image = color_entire_canvas(new_image, DEFAULT_COLOR_BG)
	new_image = copy_existing_image(new_image, raw_image)

	texture = ImageTexture.create_from_image(new_image)
	raw_image = new_image
	sprite.texture = texture
	sprite_rect = get_sprite_hitbox()
	width = new_image.get_width()
	print("current width = %s" % width)
	height = new_image.get_height()
	pass


func create_empty_image(new_width: int, new_height:int, new_format:Image.Format = Image.FORMAT_RGBA8) -> Image:

	if !accepted_formats.has(new_format):
			push_error("UNSUPPORTED FORMAT = %s" % str(new_format))
			return Image.create_empty(DEFAULT_WIDTH,DEFAULT_HEIGHT,false,Image.FORMAT_RGBA8)

	print_verbose("current format =[%s]" % accepted_formats[new_format])
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
			target.set_pixel(x,y,src.get_pixel(x,y))

	return target
