extends Camera2D

### BIT-FLAGS ENUM
### explanation https://youtu.be/FD8sEMIHPrs
## keeps track of what the camera can do in a given time
enum CameraStates {NONE = 0,
 	MOVE = (1 << 0),
 	ZOOM = (1 << 1)}

var last_position:Vector2 = Vector2(0,0)
var start_click_position:Vector2 = Vector2(0,0)
var end_click_position:Vector2 = Vector2(0,0)

var click_delta:Vector2 = Vector2(0,0)
var track_mouse_position:bool = false;
var camera_function_state: CameraStates= CameraStates.NONE
var zoom_increment_amount: float = 0.4

const ZOOM_MAX:float = 50.0;
const ZOOM_MIN:float = 0.01;

## controls how many times we can zoom in or out
const ZOOM_AMOUNT_RANGES_SEGMENTS_COUNT: int = 8
## when to change how much does the camera zooms in or out
const ZOOM_AMOUNT_RANGES:Array = [ZOOM_MAX,ZOOM_MAX / 2, 10.0,1.0, 0.1]


func _process(delta: float) -> void:
	if Input.is_action_just_pressed(InputNames.click_r):
		last_position = self.position
		start_click_position = get_local_mouse_position();
		camera_function_state = camera_function_state | CameraStates.MOVE as CameraStates

	if Input.is_action_just_released(InputNames.click_r):
		self.position = last_position + click_delta
		track_mouse_position = false;
		camera_function_state = camera_function_state ^ CameraStates.MOVE as CameraStates

	if camera_function_state & CameraStates.MOVE:
		track_mouse_mode()

	if camera_function_state & CameraStates.ZOOM:
		calculate_zoom_amount()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(InputNames.scroll_up,false,true):
		change_zoom_amount()
		camera_function_state = camera_function_state | CameraStates.ZOOM as CameraStates
		return

	if event.is_action_pressed(InputNames.scroll_down,false,true):
		change_zoom_amount(-1)
		camera_function_state = camera_function_state | CameraStates.ZOOM as CameraStates
		return

	if event.is_action_pressed(InputNames.scroll_up_fast):
		print("scroll up fast")
		change_zoom_amount(2)
		camera_function_state = camera_function_state | CameraStates.ZOOM as CameraStates

	if event.is_action_pressed(InputNames.scroll_down_fast):
		print("scroll down fast")
		change_zoom_amount(-2)
		camera_function_state = camera_function_state | CameraStates.ZOOM as CameraStates

	pass


func track_mouse_mode() -> void:
	end_click_position = get_local_mouse_position();
	click_delta = start_click_position - end_click_position;
	self.position= last_position + click_delta
	pass


func calculate_zoom_amount() -> void:
	camera_function_state = camera_function_state ^ CameraStates.ZOOM as CameraStates

	for i in ZOOM_AMOUNT_RANGES.size():
		if zoom.x >= ZOOM_AMOUNT_RANGES[i]:
			zoom_increment_amount = (ZOOM_AMOUNT_RANGES[i] / ZOOM_AMOUNT_RANGES_SEGMENTS_COUNT)
			print(" zoom_increment_amount = %s" % zoom_increment_amount)
			break;

	pass


func change_zoom_amount(multipiler: float = 1.0) -> void:
	self.zoom.x = clampf(self.zoom.x + (zoom_increment_amount * multipiler), ZOOM_MIN, ZOOM_MAX)
	self.zoom.y = clampf(self.zoom.y + (zoom_increment_amount * multipiler), ZOOM_MIN, ZOOM_MAX)
	pass
