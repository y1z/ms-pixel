extends Node2D
const DEFAULT_WIDTH:int = 128
const DEFAULT_HEIGHT:int = 128

@export_group("VARIABLES")
var raw_image: Image
var image_texture: ImageTexture
var sprite: Sprite2D
@export var current_color:Color
var sprite_rect: Rect2
var scene_camera: Camera2D

@export var scene_ui: SceneUI

const INVERSE_100:float = 1.0/100.0


func _ready() -> void:
	raw_image = Image.create_empty(DEFAULT_WIDTH, DEFAULT_HEIGHT, true, Image.Format.FORMAT_RGBA8)
	current_color = Color.INDIAN_RED
	scene_camera = $%scene_camera
	scene_ui = %TestUi
	scene_ui.start()

	scene_ui.red_scroll_bar.value_changed.connect(red_scroll_bar_change)
	scene_ui.green_scroll_bar.value_changed.connect(green_scroll_bar_change)
	scene_ui.blue_scroll_bar.value_changed.connect(blue_scroll_bar_change)

	for i in raw_image.get_height():
		for j in raw_image.get_width():
			raw_image.set_pixel(i,j, current_color)

	raw_image.get_used_rect()
	image_texture = ImageTexture.create_from_image(raw_image);
	sprite = %main_sprite
	sprite.texture = image_texture
	sprite_rect = get_sprite_hitbox()
	print(sprite_rect)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(InputNames.click_l):
		var mouse_pos := to_local(get_global_mouse_position())
		var is_inside_sprite:bool =sprite_rect.has_point(mouse_pos);

		if !is_inside_sprite: return;

		match current_color:
			Color.INDIAN_RED:
				current_color = Color.SPRING_GREEN

			Color.SPRING_GREEN:
				current_color = Color.INDIAN_RED

		change_color(current_color)
		pass

	pass


func _draw() -> void:
	if OS.is_debug_build():
		draw_rect(sprite_rect,Color.BLUE)

	pass


func get_sprite_hitbox() -> Rect2:
	var sprite_size := Vector2(sprite.texture.get_width(),sprite.texture.get_height())
	var offset:Vector2 = Vector2(sprite_size.x * 0.5,sprite_size.y * 0.5)
	return Rect2(sprite.position - offset,sprite_size) ;


func change_color(new_color: Color) -> void:
	for i in raw_image.get_height():
		for j in raw_image.get_width():
			raw_image.set_pixel(i,j, new_color)

		image_texture.set_image(raw_image)
		sprite.texture = image_texture


func red_scroll_bar_change(new_value: float) ->void:
	print("red= %s" % new_value)
	UserData.current_color.r = INVERSE_100 * new_value
	pass


func green_scroll_bar_change(new_value: float) ->void:
	print("green = %s" % new_value)
	UserData.current_color.g = INVERSE_100 * new_value
	pass


func blue_scroll_bar_change(new_value: float) ->void:
	print("blue = %s" % new_value)
	UserData.current_color.b = INVERSE_100 * new_value
	pass
