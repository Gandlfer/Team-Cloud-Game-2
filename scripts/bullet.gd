extends Sprite2D

var speed = 70
var isLeft = false

func init(dir):
	isLeft = dir

func _ready():
	scale = Vector2(0.1, 0.1)

func _physics_process(delta):
	if isLeft:
		position.x -= speed
	else:
		position.x += speed

# destroy bullet once it goes offscreen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
