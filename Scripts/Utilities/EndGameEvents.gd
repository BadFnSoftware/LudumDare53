extends Node


func _on_end_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
