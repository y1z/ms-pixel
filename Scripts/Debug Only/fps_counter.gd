extends Control

@onready var counter: Label = %Counter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	counter.text = "000fps"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !OS.is_debug_build(): return

	counter.text = str(Engine.get_frames_per_second())

	pass
