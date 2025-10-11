extends Node

#region const
const DEFAULT_WIDTH:int = 128
const DEFAULT_HEIGHT:int = 128
#endregion

@export_group("VARIABLES")
var pixel_canvas: GdPixelCanvas
var sprite: Sprite2D


func _ready() -> void:
	pixel_canvas = GdPixelCanvas.new()
	#%Canvas
	inicialize_canvas()
	#raw_image.save
	pass


func inicialize_canvas() -> void:
	pass


func save_canvas() ->bool:
	return false
