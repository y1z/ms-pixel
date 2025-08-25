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
	self.position = Vector2(0,0)
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
		print("is insde hitbox %s" % is_inside_hitbox)
		if !is_inside_hitbox : return
		var inside_sprite_pos:Vector2 = mouse_pos - sprite_rect.position
		raw_image.set_pixel(inside_sprite_pos.x,inside_sprite_pos.y,Color.GOLD)
		image_texture.update(raw_image)
		self.texture = image_texture
		pass
	
	if event.is_action_pressed("move_right"):
		self.position.x += 10.0
		pass
	pass

func _draw() -> void:
	if !OS.is_debug_build() : return
	draw_circle(sprite_rect.position,10.0,Color.YELLOW)
	pass


func get_sprite_hitbox() -> Rect2:
	var sprite_size := Vector2(self.texture.get_width(),self.texture.get_height())
	var hitbox_offset :Vector2 = Vector2(sprite_size.x * 0.5,sprite_size.y * 0.5)
	return Rect2(self.position - hitbox_offset ,sprite_size) ;
