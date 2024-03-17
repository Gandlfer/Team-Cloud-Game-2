extends StaticBody2D

@export var target_level : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Transition".visible=true
	$"../Transition".transitionToNormal()
	#$"../Transition".transitionToNormal()
	#$"../CanvasLayer".visible=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_2d_body_entered(body):
	
	if body.is_in_group("Player"): 
		# unlock powers
		print("Next Scene")
		$Area2D.queue_free()
		$AnimatedSprite2D.queue_free()
		$"../Player".set_physics_process(false)
		$"../Transition".transitionToBlack()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_packed(target_level)

