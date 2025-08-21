extends Node2D

var raw_image : Image
var image_texture : ImageTexture
var sprite : Sprite2D

func _ready() -> void:
	raw_image = Image.create(128,128,true,Image.Format.FORMAT_RGBA8)
	for i in range(0,10):
		raw_image.set_pixel(i,i,Color.INDIAN_RED)

	raw_image.get_used_rect()
	image_texture = ImageTexture.create_from_image(raw_image);
	sprite = %main_sprite
	sprite.texture = image_texture
