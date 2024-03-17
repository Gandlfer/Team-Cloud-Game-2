extends StaticBody2D

@export var target_level : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	#$"../CanvasLayer".visible=true
	$"../Transition".transitionToNormal()
	#$"../CanvasLayer".visible=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		# unlock powers
		print("Next Scene")
		$Area2D.queue_free()
		$AnimatedSprite2D.queue_free()
		$"../CharacterBody2D".set_physics_process(false)
		#$"../CanvasLayer".visible=true
		$"../Transition".transitionToBlack()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_packed(target_level)

