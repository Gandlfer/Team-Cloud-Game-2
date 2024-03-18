extends Node

func _ready():
	$BgMusic.play()

func _on_start_pressed():
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://scenes/levels/level_1/DoubleJump.tscn")


func _on_customization_pressed():
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://scenes/items/HatSelection/ChoosingHats.tscn")
