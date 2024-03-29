extends StaticBody2D

@export var damage: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.damaged=true
		await get_tree().create_timer(2).timeout
		
		for x in $Area2D.get_overlapping_bodies():
			_on_area_2d_body_entered(x)


func temp(body):
	while(true):
		for x in $Area2D.get_overlapping_bodies():
			if(x.is_in_group("Player")):
				body.damaged=true
			else:
				break
