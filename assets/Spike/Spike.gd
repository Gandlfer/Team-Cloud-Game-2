extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name=="CharacterBody2D":
		print("Damaged")
		body.damaged=true
		await get_tree().create_timer(1).timeout
		print(body.damaged)
		for x in $Area2D.get_overlapping_bodies():
			_on_area_2d_body_entered(x)
		
	pass # Replace with function body.
func temp(body):
	while(true):
		for x in $Area2D.get_overlapping_bodies():
			if(x.name == "CharacterBody2D"):
				body.damaged=true
			else:
				break
