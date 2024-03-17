extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	#transition()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func transitionToBlack():
	$AnimationPlayer.play("fade_to_black")
	#print("Fade to black")
	
func transitionToNormal():
	$AnimationPlayer.play("fade_to_normal")
	
