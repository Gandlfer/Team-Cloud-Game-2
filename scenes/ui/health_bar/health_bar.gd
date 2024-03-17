extends Node2D

@export var heart_full: Texture2D
@export var heart_empty: Texture2D

@onready var heart_1 = $Heart1
@onready var heart_2 = $Heart2
@onready var heart_3 = $Heart3


# Called when the node enters the scene tree for the first time.
func _ready():
	HealthManager.on_health_change.connect(on_player_health_changed)


func on_player_health_changed(player_current_health: int):
	if player_current_health == 3:
		heart_3.texture = heart_full
	elif player_current_health < 3:
		heart_3.texture = heart_empty
		
	if player_current_health == 2:
		heart_2.texture = heart_full
	elif player_current_health < 2:
		heart_2.texture = heart_empty
		
	if player_current_health == 1:
		heart_1.texture = heart_full
	elif player_current_health < 1:
		heart_1.texture = heart_empty
