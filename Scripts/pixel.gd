extends Sprite2D
#region const
const DEFAULT_WIDTH : int = 128
const DEFAULT_HEIGHT: int = 128
#endregion

var raw_image : Image
var current_color :Color
var image_texture : ImageTexture
var sprite_rect : Rect2

func _ready() -> void:
	raw_image = Image.create_empty(DEFAULT_WIDTH , DEFAULT_HEIGHT, true , Image.Format.FORMAT_RGBA8)
	image_texture = ImageTexture.create_from_image(raw_image)
	self.texture = image_texture
	current_color = Color.BLACK
	sprite_rect = get_sprite_hitbox()
	
	for i in raw_image.get_height():
		for j in raw_image.get_width():
			raw_image.set_pixel(i,j, current_color)
	
	image_texture  =ImageTexture.create_from_image(raw_image)
	self.texture = image_texture
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("l_click"):
		var mouse_pos := to_local(get_global_mouse_position())
		var is_inside_hitbox :bool = sprite_rect.has_point(mouse_pos)
		if !is_inside_hitbox : return
		#print("is insde hitbox %s" % is_inside_hitbox)
		var inside_sprite_pos:Vector2 = mouse_pos - sprite_rect.position
		@warning_ignore_start("narrowing_conversion")
		raw_image.set_pixel(inside_sprite_pos.x,inside_sprite_pos.y,Color.GOLD)
		@warning_ignore_restore("narrowing_conversion")
		image_texture.update(raw_image)
		self.texture = image_texture
		pass
	pass

func _draw() -> void:
	if !OS.is_debug_build() : return
	draw_circle(sprite_rect.position,10.0,Color.YELLOW)
	var rect_color := Color.YELLOW
	rect_color.a = 0.5;
	draw_rect(sprite_rect,rect_color)
	pass


func get_sprite_hitbox() -> Rect2:
	var sprite_size := Vector2(self.texture.get_width(),self.texture.get_height())
	return Rect2(self.get_rect().position ,sprite_size) ;
