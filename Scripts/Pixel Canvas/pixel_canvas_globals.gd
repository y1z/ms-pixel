class_name PixelCanvasGlobals extends Node

enum SavingFormats {
	TEXT,
	BINARY,
}

const accepted_formats: Dictionary = {
	Image.FORMAT_RGBA8: "Image.FORMAT_RGBA8",
	Image.FORMAT_RGB8: "Image.FORMAT_RGB8",
}

const save_dir: String = "user://saves/"
