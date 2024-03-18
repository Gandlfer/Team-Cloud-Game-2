extends Node2D

var start_pos = position.x
var limit_left = 1900
var limit_right = 3250
const DASH_SPEED = 60
const GRAVITY = 5500

var xVel = 0

var fightStarted = false
var canAttack = true
var attacking = false
var direction = "left"
var secondDash = false

var a

@warning_ignore("shadowed_variable")
func damage(b):
	b.get_parent().queue_free()
	$BossHealthbar.value -= 5
	if $BossHealthbar.value <= 0:
		queue_free()

func _on_area_2d_area_entered(area):
	if 'Bullet' in area.get_parent().name:
		damage(area)

func _physics_process(_delta):
	if $RayCast2D.is_colliding():
		fightStarted = true
	
	if fightStarted:
		if canAttack:
			a = floor(randf_range(0, 2))
			attacking = false
			canAttack = false
			print(a)
			$AttackStartup.start()
		
		if attacking:
			if a == 0:
				if direction == "left":
					position.x -= DASH_SPEED
					
					if position.x < limit_left:
						#canAttack = false
						attacking = false
						$AttackCooldown.start()
						direction = "right"
				else:
					position.x += DASH_SPEED
					
					if position.x > limit_right:
						#canAttack = false
						attacking = false
						$AttackCooldown.start()
						direction = "left"
			else:
				if direction == "left":
					position.x -= DASH_SPEED
					
					if position.x < limit_left:
						if !secondDash:
							direction = "right"
							secondDash = true
						else:
							#canAttack = false
							attacking = false
							$AttackCooldown.start()
							direction = "right"
							secondDash = false
				else:
					position.x += DASH_SPEED
					
					if position.x > limit_right:
						if !secondDash:
							direction = "left"
							secondDash = true
						else:
							#canAttack = false
							attacking = false
							$AttackCooldown.start()
							direction = "left"
							secondDash = false
			#elif a == 2:
				
			
			


func _on_attack_cooldown_timeout():
	canAttack = true


func _on_attack_startup_timeout():
	print("attacking")
	attacking = true
