extends Sprite2D

var gunTransform = Transform2D()

# Called when the node enters the scene tree for the first time.
func _ready():
	var gun = $Gun


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var node = $MyNode
	if Input.is_action_pressed("left"):
		print("facing left!")
		gunTransform = gunTransform.translated(Vector2(-44,0)).rotated(deg_to_rad(45))
	if Input.is_action_just_pressed("right"):
		print("facing right!")
	gunTransform = gunTransform.translated(Vector2(44,0))
