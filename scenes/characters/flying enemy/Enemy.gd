extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var player_position
var target_position
@onready var player = get_parent().get_node("CharacterBody2D")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hit
var ishit=false
var playerbody 
func _physics_process(delta):
	player_position=player.position
	target_position = (player_position-position).normalized()
	#print(position.distance_to(player_position))
	if position.distance_to(player_position)<300 and position.distance_to(player_position)>50 and !hit:
		velocity=target_position * SPEED
		move_and_slide()
	
	if hit and !ishit:
		hitcd()

func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		if (body.dashing):
			print("Dash")
			$Area2D.queue_free()
			$Area2D2.queue_free()
			$CollisionShape2D.queue_free()
			$AnimatedSprite2D.queue_free()
		else:
			#print("damaged")
			playerbody=body
			hit = true
			



func _on_area_2d_body_exited(body):
	hit = false
	pass # Replace with function body.

func hitcd():
	ishit=true
	playerbody.damaged=true
	await get_tree().create_timer(2).timeout
	ishit=false


func _on_area_2d_2_body_entered(body):
	if body.name=="CharacterBody2D" and body.groundSlamming:
		print("Groundslam")
		$Area2D2.queue_free()
		$"Area2D".queue_free()
		$CollisionShape2D.queue_free()
		$AnimatedSprite2D.queue_free()
	# Replace with function body.
