extends Node


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_1/DoubleJump.tscn")


func _on_customization_pressed():
	get_tree().change_scene_to_file("res://scenes/items/HatSelection/ChoosingHats.tscn")
