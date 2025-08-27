extends Node

#region const
const DEFAULT_WIDTH:int = 128
const DEFAULT_HEIGHT:int = 128
#endregion

@export_group("VARIABLES")
@export var canvas_size :Vector2i = Vector2i(DEFAULT_WIDTH, DEFAULT_HEIGHT) 
var raw_image : Image

func _ready() -> void:
	inicialize_canvas()
	#raw_image.save
	var thing := PixelCanvas.new();
	print("[LOG] is pixel Canvas working = %s" % thing.test_is_working())
	pass

func inicialize_canvas() -> void:
	pass


func save_canvas() ->bool :
	return false
