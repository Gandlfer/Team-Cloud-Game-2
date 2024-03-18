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
			a = randi_range(0, 1)
			attacking = false
			canAttack = false
			$ExclaimationPoint.visible = true
			if a == 1:
				$ExclaimationPoint2.visible = true
				$ExclaimationPoint3.visible = true
			
			$AttackStartup.start()
		
		if attacking:
			if a == 0:
				if direction == "left":
					$ExclaimationPoint.visible = false
					position.x -= DASH_SPEED
					
					if position.x < limit_left:
						#canAttack = false
						attacking = false
						$AttackCooldown.start()
						direction = "right"
				else:
					$ExclaimationPoint.visible = false
					position.x += DASH_SPEED
					
					if position.x > limit_right:
						#canAttack = false
						attacking = false
						$AttackCooldown.start()
						direction = "left"
			else:
				if direction == "left":
					$ExclaimationPoint.visible = false
					$ExclaimationPoint2.visible = false
					$ExclaimationPoint3.visible = false
					position.x -= DASH_SPEED
					
					if position.x < limit_left:
						if !secondDash:
							direction = "right"
							secondDash = true
						else:
							#canAttack = false
							attacking = false
							$ExclaimationPoint.visible = false
							$AttackCooldown.start()
							direction = "right"
							secondDash = false
				else:
					$ExclaimationPoint.visible = false
					$ExclaimationPoint2.visible = false
					$ExclaimationPoint3.visible = false
					position.x += DASH_SPEED
					
					if position.x > limit_right:
						if !secondDash:
							direction = "left"
							secondDash = true
						else:
							#canAttack = false
							attacking = false
							$ExclaimationPoint.visible = false
							$AttackCooldown.start()
							direction = "left"
							secondDash = false
			#elif a == 2:
				
			
			


func _on_attack_cooldown_timeout():
	canAttack = true


func _on_attack_startup_timeout():
	attacking = true


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.damaged=true
		await get_tree().create_timer(2).timeout
		
		for x in $Area2D.get_overlapping_bodies():
			_on_area_2d_body_entered(x)
