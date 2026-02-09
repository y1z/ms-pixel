class_name GdColorPosition extends Object

var positions: Array[Vector2i]
var colors: Array[Color]
var count: int = 0;


func get_color(index: int) -> Color:
	Util.assert_in_range(index, colors.size())
	return colors[index]


class GdColorAndPosition:
	var position: Vector2i
	var color: Color
