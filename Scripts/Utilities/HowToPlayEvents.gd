extends Node


func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")