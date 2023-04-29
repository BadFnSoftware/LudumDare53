extends Node

var arrow = load("res://Assets/UI/Cursor/spr_cursor_01.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(arrow)
