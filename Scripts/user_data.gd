extends Node
# UserData
var current_color : Color


func _ready() -> void:
	
	if current_color == null:
		current_color = Color.INDIAN_RED
	pass
