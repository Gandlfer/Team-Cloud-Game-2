extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().name == "DoubleJumpLevel":
		Global.level=2
		Global.Ability_Unlocked="Dash"
		Global.Ability_Description="Press K to dash"
	elif get_parent().name == "TestingScene":
		Global.level=1
		Global.Ability_Unlocked="Test"
		Global.Ability_Description="Test"
	elif get_parent().name == "Node":
		Global.Ability_Unlocked="Magnum Gun"
		Global.Ability_Description="Press L to shoot bullets"
		Global.level=3
	elif get_parent().name == "BossLevel":
		Global.level=0
	$"../Transition".visible=true
	$"../Transition".transitionToNormal()
	
	#print($"../Level Done/ChoosingHats/StaticBody2D".find_child("Player"))
	#$"../Level Done/ChoosingHats/StaticBody2D".find_child("Player").set_physics_process(false)
	#$"../Level Done/ChoosingHats/StaticBody2D/CollisionShape2D4".disabled=true
	#$"../Level Done/ChoosingHats/StaticBody2D/CollisionShape2D3".disabled=true
	#$"../Level Done/ChoosingHats/StaticBody2D/CollisionShape2D2".disabled=true
	#$"../Level Done/ChoosingHats/StaticBody2D/CollisionShape2D".disabled=true
	#$StaticBody2D/CollisionShape2D4.disabled=false
	#$StaticBody2D/CollisionShape2D.disabled=false
	#$StaticBody2D/CollisionShape2D3.disabled=false
	#$StaticBody2D/CollisionShape2D2.disabled=false
	#$"../Transition".transitionToNormal()
	#$"../CanvasLayer".visible=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_2d_body_entered(body):
	
	if body.is_in_group("Player") and visible: 
		$SoundTwinkle.play()
		await get_tree().create_timer(0.5).timeout
		# unlock powers
		print("Next Scene")
		$Area2D.queue_free()
		$AnimatedSprite2D.queue_free()
		$"../Player".set_physics_process(false)
		$"../Transition".transitionToBlack()
		await get_tree().create_timer(0.5).timeout
		$"../Player/Camera2D".enabled=false
		$"../Transition".visible=false
		#$"../Level Done".visible = true
		#$"../Level Done/Camera2D".enabled = true
		
		if get_parent().name != "BossLevel":
			get_tree().change_scene_to_file("res://Level Done/level_done.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/winscreen.tscn")
