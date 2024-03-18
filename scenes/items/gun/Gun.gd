extends Sprite2D

signal gunShotRight
signal gunShotLeft
signal gunShotDown
signal gunShotUp

#@onready var gun = $Sprite2D

var gunRight = true
var gunUp = false
var gunDown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_position(Vector2(25,0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gunUp = false
	gunDown = false
	#var node = $MyNode
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
	if Input.is_action_pressed("down"):
		gunRight = false
		gunDown = true
		set_flip_h(false)
		set_position(Vector2(0,25))
		set_global_rotation(deg_to_rad(90))
	if Input.is_action_pressed("up"):
		gunRight = false
		gunUp = true
		set_flip_h(true)
		set_flip_v(true)
		set_position(Vector2(0,-25))
		set_global_rotation(deg_to_rad(90))
	if Input.is_action_just_pressed("shoot"):
		print("bang!")
		if gunRight == true:
			gunShotRight.emit()
		if gunRight == false:
			if gunUp == true:
				gunShotUp.emit()
			elif gunDown == true:
				gunShotDown.emit()
			else:
				gunShotLeft.emit()

