extends Node2D

var player_scene = preload("res://scenes/characters/player/player.tscn")
var player: CharacterBody2D = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player == null:
		var new_player = player_scene.instantiate()
		new_player.position = position
		get_parent().add_child(new_player)
		HealthManager.add_health(3)
		player = new_player
