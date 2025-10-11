class_name Pixel extends Sprite2D
### REPLACE THIS SCRIPT WITH gd_pixel_canvas.gd (MAYBE I can use this later (having trouble with making a plug-in))
### 
#region const
const DEFAULT_WIDTH: int = 128
const DEFAULT_HEIGHT: int = 128
#endregion

var raw_image: Image
var image_texture: ImageTexture
var sprite_rect: Rect2

var pixel_canvas: GdPixelCanvas;

@export var turn_on_debug_things: bool = false;


func _ready() -> void:
	pixel_canvas = GdPixelCanvas.new()
	raw_image = Image.create_empty(DEFAULT_WIDTH, DEFAULT_HEIGHT, false, Image.Format.FORMAT_RGBA8)
	image_texture = ImageTexture.new()
	image_texture = ImageTexture.create_from_image(raw_image)
	var background_color := Color.BLACK

	for i in raw_image.get_height():
		for j in raw_image.get_width():
			raw_image.set_pixel(i,j, background_color)

	image_texture.update(raw_image)
	self.texture = image_texture
	sprite_rect = get_sprite_hitbox()
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(InputNames.click_l):
		var mouse_pos := to_local(get_global_mouse_position())
		var is_inside_hitbox:bool = sprite_rect.has_point(mouse_pos)

		if !is_inside_hitbox: return
		#print("is insde hitbox %s" % is_inside_hitbox)
		var inside_sprite_pos:Vector2 = mouse_pos - sprite_rect.position

		@warning_ignore_start("narrowing_conversion")
		raw_image.set_pixel(inside_sprite_pos.x, inside_sprite_pos.y, UserData.current_color)
		@warning_ignore_restore("narrowing_conversion")
		image_texture.update(raw_image)
		self.texture = image_texture
		pass

	if event.is_action_pressed(InputNames.turn_on_debug):
		turn_on_debug_things = !turn_on_debug_things

	pass


func _draw() -> void:
	if !turn_on_debug_things: return
	draw_circle(sprite_rect.position,10.0,Color.YELLOW)
	var rect_color := Color.YELLOW
	rect_color.a = 0.5;
	draw_rect(sprite_rect,rect_color)
	pass


func get_sprite_hitbox() -> Rect2:
	var sprite_size := Vector2(self.texture.get_width(),self.texture.get_height())
	return Rect2(self.get_rect().position,sprite_size) ;


func draw_line_l(start: Vector2i, end: Vector2i) -> void:
	pixel_canvas.draw_line_l(start,end);
	pass
