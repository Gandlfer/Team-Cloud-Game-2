extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D" and body.groundSlamming:
		print("true")
		$GPUParticles2D.emitting=true
		$Area2D.queue_free()
		$CollisionShape2D.queue_free()
		$Sprite2D.queue_free()
	pass # Replace with function body.
