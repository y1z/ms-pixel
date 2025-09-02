extends Camera2D


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_down"):
		self.offset -= (Vector2(0,-1) * 100.0) * delta
		
	if Input.is_action_pressed("move_up"):
		self.offset += (Vector2(0,-1) * 100.0) * delta
		
	if Input.is_action_pressed("move_left"):
		self.offset -= (Vector2(1,0) * 100.0) * delta
		
	if Input.is_action_pressed("move_right"):
		self.offset += (Vector2(1,0) * 100.0) * delta
		
	if Input.is_action_just_released("scroll_up"):
		self.zoom.x += 3.0 * delta
		self.zoom.y += 3.0 * delta
		pass
		
	if Input.is_action_just_released("scroll_down"):
		self.zoom.x -= 3.0 * delta
		self.zoom.y -= 3.0 * delta
		pass
