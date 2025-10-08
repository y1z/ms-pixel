extends Control

var text:Label;


func _ready() -> void:
	text = %Label
	text.text = "the current platform is = %s" % OS.get_name()
