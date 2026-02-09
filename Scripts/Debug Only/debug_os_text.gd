extends Control

var text: Label;


func _ready() -> void:
	if !OS.is_debug_build(): return

	text = %Label
	text.text = "the current platform is = %s" % OS.get_name()
