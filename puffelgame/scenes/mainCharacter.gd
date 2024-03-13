extends CharacterBody2D

@onready var sprite_2d = $Sprite2D

const SPEED = 600.0
const DASH_SPEED = 3800
const GROUND_SLAM_SPEED = 4000
const JUMP_VELOCITY = -1300.0
const GRAVITY = 5500

var gravity = GRAVITY
var canDoubleJump = false

var dashOnCooldown = false
var canDash = true
var dashing = false

var dashDirection = 1
var isLeft = false

var groundSlamming = false


func _physics_process(delta):
	# animations
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "run"
	else:
		sprite_2d.animation = "default"
	
	# floor checks
	if is_on_floor():
		groundSlamming = false
		if !dashOnCooldown:
			canDash = true
	if not is_on_floor():
		if(!groundSlamming):
			velocity.y += gravity * delta
		sprite_2d.animation = "jump"
		
	# handles inputs for jump and double jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		canDoubleJump = true
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("jump") and !is_on_floor() and canDoubleJump:
		canDoubleJump = false
		velocity.y = JUMP_VELOCITY
		
	# when you release jump your y vel is divided by 3 so you can control your jump height
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY/3
	
	# reduces gravity when at the peak of your jump and when youre holding jump so that max height jumps are floatier
	if velocity.y > -60 and velocity.y < 60 and Input.is_action_pressed("jump"):
		gravity = GRAVITY/6
	else:
		gravity = GRAVITY
	
	# handles input for ground slam
	if Input.is_action_just_pressed("jump") and Input.is_action_pressed("down") and !is_on_floor():
		groundSlamming = true
	
	#handles input for dash
	if Input.is_action_just_pressed("dash") and canDash:
		dashing = true
		dashOnCooldown = true
		canDash = false
		$DashTimer.start()
		$DashCooldown.start()
		
	# sets velocities when ground slamming or dashing
	if groundSlamming:
		velocity.y = GROUND_SLAM_SPEED
		velocity.x = 0
	
	if(dashing):
		velocity.x = dashDirection * DASH_SPEED
		velocity.y = 0
	
	# left and right movement
	var direction = Input.get_axis("left", "right")
	if direction and !dashing and !groundSlamming:
		velocity.x = direction * SPEED
		dashDirection = direction
	elif !dashing and !groundSlamming:
		#commented line gradually slows puffel down instead of an instant stop
		#velocity.x = move_toward(velocity.x, 0, 100)
		velocity.x = 0
	move_and_slide()
	
	# makes the player keep facing the direction of the last button they pressed
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

# dash duration timer
func _on_dash_timer_timeout():
	dashing = false

# dash cooldown timer, so you can't spam dash on the ground
func _on_dash_cooldown_timeout():
	dashOnCooldown = false