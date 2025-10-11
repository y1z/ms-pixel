extends Node2D
const DEFAULT_WIDTH:int = 128
const DEFAULT_HEIGHT:int = 128

@export_group("VARIABLES")
var raw_image: Image
var image_texture: ImageTexture

@export var scene_ui: SceneUI

var pixel_in_focus: Pixel;

const INVERSE_100:float = 1.0/100.0


func _ready() -> void:
	var pc := PixelCanvas.new();
	pc.start()
	raw_image = Image.create_empty(DEFAULT_WIDTH, DEFAULT_HEIGHT, true, Image.Format.FORMAT_RGBA8)
	scene_ui = %TestUi
	scene_ui.color_picker.color_changed.connect(on_color_changed)

	for i in raw_image.get_height():
		for j in raw_image.get_width():
			raw_image.set_pixel(i,j, Color.BLACK)

	raw_image.get_used_rect()
	image_texture = ImageTexture.create_from_image(raw_image);


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(InputNames.line_mode):
		if UserData.draw_modes != UserData.DrawModes.LINES:
			change_draw_mode(UserData.DrawModes.LINES)
			UserData.print_draw_mode()
		else:
			change_draw_mode(UserData.DrawModes.PUT_PIXEL)
			UserData.print_draw_mode()


func change_color(new_color: Color) -> void:
	for i in raw_image.get_height():
		for j in raw_image.get_width():
			raw_image.set_pixel(i,j, new_color)

		image_texture.set_image(raw_image)


func on_color_changed(new_color: Color) -> void:
	UserData.current_color = new_color


func change_draw_mode(new_draw_mode: UserData.DrawModes) -> void:
	UserData.draw_modes = new_draw_mode;
