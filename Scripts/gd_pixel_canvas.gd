class_name GdPixelCanvas extends Node2D

const DEFAULT_WIDTH:int = 128
const DEFAULT_HEIGHT:int = 128

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


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(InputNames.click_l):
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
			resize(64,64)
		else:
			resize(DEFAULT_WIDTH, DEFAULT_HEIGHT)

		pass

	pass


func start() -> void:
	format = Image.FORMAT_RGBA8
	raw_image = Image.create_empty(DEFAULT_WIDTH,DEFAULT_HEIGHT,false,format)
	texture = ImageTexture.create_from_image(raw_image)
	give_default_pattern(raw_image);
	texture.update(raw_image)
	sprite.texture = texture
	sprite_rect = get_sprite_hitbox()
	pass


func resize(new_width: int, new_height:int) -> void:
	var new_image:Image = create_empty_image(new_width, new_height);
	var new_image_size: Vector2i = Vector2i(new_image.get_width(), new_image.get_height())
	var current_image_size: Vector2i = Vector2i(raw_image.get_width(), raw_image.get_height())

	if (new_image_size.x >= current_image_size.x) && (new_image_size.y >= current_image_size.y):
		new_image.copy_from(raw_image)

	texture = ImageTexture.create_from_image(new_image)
	pass


func create_empty_image(new_width: int, new_height:int, new_format:Image.Format = Image.FORMAT_RGBA8) -> Image:

	if accepted_formats.find_key(new_format) == null:
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


func get_sprite_hitbox() -> Rect2:
	var sprite_size := Vector2(self.texture.get_width(),self.texture.get_height())
	return Rect2(sprite.get_rect().position,sprite_size) ;
