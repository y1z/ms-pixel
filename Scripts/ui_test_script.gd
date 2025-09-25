extends Control
class_name SceneUI

@export_group("VARIABLES")
@export var red_scroll_bar:HScrollBar
@export var green_scroll_bar:HScrollBar
@export var blue_scroll_bar:HScrollBar


func _ready() -> void:
	red_scroll_bar = %"red scroll bar"
	green_scroll_bar = %"green scroll bar"
	blue_scroll_bar = %"blue scroll bar"


func start() ->void:
	# HACK: this is only done because by default the bars values are from 0 to 90 (probably something I did)
	red_scroll_bar.max_value = 110.0
	red_scroll_bar.min_value = 0.0

	green_scroll_bar.max_value = 110.0
	green_scroll_bar.min_value = 0.

	blue_scroll_bar.max_value = 110.0
	blue_scroll_bar.min_value = 0.0
