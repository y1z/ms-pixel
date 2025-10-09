class_name GdPixelCanvas extends Resource

const DEFAULT_WIDTH:int = 128
const DEFAULT_HEIGHT:int = 128

var texture: ImageTexture
var raw_image: Image
var format: Image.Format
var width: int
var height: int


func _init() -> void:
	start();


func start() -> void:
	format = Image.FORMAT_RGBA8
	pass


func resize(new_width: int, new_height:int) -> void:
	raw_image.create_from_image(new_height,)
	pass
