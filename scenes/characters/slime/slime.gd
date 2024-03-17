extends CharacterBody2D

@export var patrol_points: Node
@export var speed: int = 1500
@export var wait_time: int = 2
@export var health: int = 1
@export var damage: int = 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer

const GRAVITY = 5500

enum State { Idle, Walk }

var current_state: State
var direction: Vector2 = Vector2.LEFT
var number_of_patrol_points: int
var point_positions: Array[Vector2]
var current_point: Vector2
var current_point_position: int
var can_walk: bool = false


func _ready():
	if patrol_points != null:
		number_of_patrol_points = patrol_points.get_child_count()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("Error: No patrol points found")
	
	timer.wait_time = wait_time
	current_state = State.Idle
	
	
func _physics_process(delta: float):
	enemy_gravity(delta)
	enemy_idle(delta)
	enemy_walk(delta)
	move_and_slide()
	enemy_animations()
	
func enemy_gravity(delta: float):
	velocity.y += GRAVITY * delta


func enemy_idle(delta: float):
	if !can_walk:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		current_state = State.Idle


func enemy_walk(delta: float):
	if !can_walk: return
	
	if abs(position.x - current_point.x) > 0.5:
		velocity.x = direction.x * speed * delta
		current_state = State.Walk
	else:
		current_point_position += 1
	
		if current_point_position >= number_of_patrol_points:
			current_point_position = 0
	
		current_point = point_positions[current_point_position]
	
		if current_point.x > position.x:
			direction = Vector2.RIGHT
		else:
			direction = Vector2.LEFT
			
		can_walk = false
		timer.start()
		
	animated_sprite_2d.flip_h = direction.x > 0


func enemy_animations():
	if current_state == State.Idle && !can_walk:
		animated_sprite_2d.play("idle")
	elif current_state == State.Walk && can_walk:
		animated_sprite_2d.play("walk")

func _on_timer_timeout():
	can_walk = true


# Enemy dies when Puffel jumps on its head
func _on_hurtbox_area_entered(area: Area2D):
	if area.get_parent().has_method("get_jump_damage_amount"):
		var node = area.get_parent() as Node
		health -= node.JUMP_DAMAGE
		
		if health <= 0:
			queue_free()
