extends Sprite2D

const DEFAULT_WIDTH : int = 128
const DEFAULT_HEIGHT: int = 128
var raw_image : Image
var current_color :Color
var image_texture : ImageTexture

func _ready() -> void:
	raw_image = Image.create_empty(DEFAULT_WIDTH , DEFAULT_HEIGHT, true , Image.Format.FORMAT_RGBA8)
	current_color = Color.MISTY_ROSE
	
	for i in raw_image.get_height():
		for j in raw_image.get_width():
			raw_image.set_pixel(i,j, current_color)
	
	image_texture  =ImageTexture.create_from_image(raw_image)
	self.texture = image_texture
	pass
	
