extends Camera2D

var zoomed = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().position.y > 2500:
		zoomed = true
	
	if zoomed:
		zoom = zoom.move_toward(Vector2(0.5, 0.5), 0.0005)
		limit_left = 1152
		# position = position.move_toward(Vector2(30, 2500), 2)
