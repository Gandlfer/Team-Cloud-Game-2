extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
var save_path="res://Saved//data.json"

# @onready var gunSignal = get_node("Gun")

const SPEED = 600.0
const DASH_SPEED = 3800
const GROUND_SLAM_SPEED = 4000
const JUMP_VELOCITY = -1300.0
const GUN_VELOCITY = 2000.0
const GRAVITY = 5500
const JUMP_DAMAGE = 1

var gravity = GRAVITY
var canDoubleJump = false

var dashOnCooldown = false
var canDash = true
var isDamage = false

var dashDirection = 1
var isLeft = false

var hatNode = "Hats%d"
@export var dash = false

@export var hats=[]
@export var currenthat=-1
@export var damaged = false
@export var groundSlamming = false
@export var dashing = false

func _ready():
	load_data()
	#print(get_parent().name)
	if get_parent().name == "DoubleJumpLevel":
		#print("true")
		dash = false
	else:
		dash = true
	# gunSignal.gunShotDown.connect(_gun_shoot_down)
	# gunSignal.gunShotUp.connect(_gun_shoot_up)
	# gunSignal.gunShotLeft.connect(_gun_shoot_left)
	# gunSignal.gunShotRight.connect(_gun_shoot_right)
	pass


func _physics_process(delta):
	# animations
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "run_puffel"
	else:
		sprite_2d.animation = "new_animation"
	
	# floor checks
	if is_on_floor():
		groundSlamming = false
		if !dashOnCooldown:
			canDash = true
	if not is_on_floor():
		if(!groundSlamming):
			velocity.y += gravity * delta
		sprite_2d.animation = "jump_puffel"
		
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
	if Input.is_action_pressed("dash") and canDash and dash:
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
	
	if(damaged and !isDamage):
		isDamage= true
		flicker()
		#print("Damaged here")
		velocity.y = -750 # bounce upwards when damage
		
	
	
# dash duration timer
func _on_dash_timer_timeout():
	dashing = false

# dash cooldown timer, so you can't spam dash on the ground
func _on_dash_cooldown_timeout():
	dashOnCooldown = false

func flicker():
	for x in 3:
		$Sprite2D.visible = false
		#print("flicker")
		await get_tree().create_timer(0.1).timeout
		$Sprite2D.visible = true
		await get_tree().create_timer(0.1).timeout
	#print("Done")
	damaged = false
	isDamage=false

func _gun_shoot_down():
	velocity.y -= GUN_VELOCITY
func _gun_shoot_up():
	velocity.y += GUN_VELOCITY
func _gun_shoot_left():
	print("left sig recieved")
	velocity.x -= GUN_VELOCITY
func _gun_shoot_right():
	print("right sig recieved")
	velocity.x += GUN_VELOCITY

func save():
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_string(JSON.new().stringify(hats))
	file.close()
	
func load_data():
	if FileAccess.file_exists(save_path):
		var file =FileAccess.open(save_path,FileAccess.READ)
		hats = str_to_var(file.get_as_text())
		file.close()
	else:
		print("No saved.")
		
func _on_left_pressed():
	if hats.size()!=0:
		if currenthat==-1:
			currenthat=hats.size()-1
		else:
			get_node(hatNode % currenthat).visible=false
			if currenthat==0:
				currenthat=hats.size()-1
			else:
				currenthat-=1
		get_node(hatNode % currenthat).visible=true


func _on_right_pressed():
	if hats.size()!=0:
		if currenthat==-1:
			currenthat=0
		else:
			get_node(hatNode % currenthat).visible=false
			if currenthat==hats.size()-1:
				currenthat=0
			else:
				currenthat+=1
		get_node(hatNode % currenthat).visible=true
		
		
func get_jump_damage_amount():
	return JUMP_DAMAGE


func _on_hurtbox_area_entered(area):
	if area.is_in_group("Enemy"):
		HealthManager.minus_health(area.damage)

func _on_hurtbox_body_entered(body: Node2D):
	if body.is_in_group("Enemy"):
		HealthManager.minus_health(body.damage)
