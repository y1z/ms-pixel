extends Node2D

const DEFAULT_WIDTH:int = 128
const DEFAULT_HEIGHT :int = 128

@export_group("VARIABLES")
var raw_image : Image
var image_texture : ImageTexture
var sprite : Sprite2D
@export var currrent_color :Color 
var sprite_rect : Rect2

func _ready() -> void:
	raw_image = Image.create_empty(DEFAULT_WIDTH , DEFAULT_HEIGHT, true , Image.Format.FORMAT_RGBA8)
	currrent_color = Color.INDIAN_RED
	
	for i in raw_image.get_height():
		for j in raw_image.get_width():
			raw_image.set_pixel(i,j, currrent_color)

	raw_image.get_used_rect()
	image_texture = ImageTexture.create_from_image(raw_image);
	sprite = %main_sprite
	sprite.texture = image_texture
	sprite_rect = get_sprite_hitbox() 
	print(sprite_rect)
	
func _input(event: InputEvent) -> void:
	if  event.is_action_pressed("l_click"):
		var mouse_pos := to_local(get_global_mouse_position())
		print( "clicked inside raw_image %s" % sprite_rect.has_point(mouse_pos ))
		pass
		
		pass
	pass

func _draw() -> void:
	if OS.is_debug_build():
		draw_rect(sprite_rect,Color.BLUE)
	pass

func get_sprite_hitbox() -> Rect2:
	var sprite_size := Vector2(sprite.texture.get_width(),sprite.texture.get_height())
	var offset :Vector2 = Vector2(sprite_size.x * 0.5,sprite_size.y * 0.5)
	return Rect2(sprite.position - offset,sprite_size) ;
	
