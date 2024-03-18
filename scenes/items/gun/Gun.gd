extends Sprite2D

var gunRight = true

# Called when the node enters the scene tree for the first time.
func _ready():
	set_position(Vector2(25,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_global_rotation(0)
	set_flip_v(false)
	if Input.is_action_pressed("left") or gunRight == false:
		gunRight = false
		set_position(Vector2(-25,0))
		set_flip_h(true)
	if Input.is_action_pressed("right") or gunRight == true:
		gunRight = true
		set_position(Vector2(25,0))
		set_flip_h(false)
