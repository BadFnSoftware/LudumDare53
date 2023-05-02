extends Node

var SoundPlayerNode: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	SoundPlayerNode = get_node("%AudioStreamPlayer")
	SoundController.playSound("buttonpress1", SoundPlayerNode)


func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")
