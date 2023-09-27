extends CharacterBody2D


const SPEED = 3500.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var collision_detector = $collision_detector
var direction = -1
var aux_direction = 0
var is_near_wall = false
var jump_vector = Vector2.ZERO
@onready var animation = $AnimatedSprite2D as AnimatedSprite2D
@onready var collision_timer = $collision_timer
@onready var jump_timer = $jump_timer
var jump_time = false
@onready var shoot_timer = $shoot_timer
@onready var projetile_scene = preload("res://prefabs/boss_projetile.tscn") as PackedScene

func _physics_process(delta):
	if jump_timer.is_stopped():
		jump_timer.start()
	if shoot_timer.is_stopped():
		print('entrou')
		shoot_timer.start()
	# Add the gravity.,
	if not is_on_floor():
			velocity.y += gravity * delta
	if collision_detector.is_colliding():
		aux_direction = direction
		direction = 0
		collision_timer.start()
		collision_detector.scale.x *= -1 
		direction = direction * -1
		animation.scale.x *= -1
	if is_on_floor() and !jump_time:
		velocity.x = direction * SPEED * delta
	
	
	move_and_slide()
	_set_state()

func _set_state():
	var state = "idle"
	if direction != 0 and not jump_time and is_on_floor():
		state = "run"
	if jump_time:
		state = "jump"
	if animation.animation != state:
		animation.play(state)
	


func _on_collision_timer_timeout():
	direction = collision_detector.scale.x * -1
	is_near_wall = false


func _on_jump_timer_timeout():
	jump_time = true
	await get_tree().create_timer(0.2).timeout
	jump_timer.stop()
	_jump_move(Vector2(100*direction,-500),0.25)

func _jump_move(jump_force = Vector2.ZERO, duration = 0.25):
	if jump_force != Vector2.ZERO:
		jump_vector = jump_force
		var knockback_tween = get_tree().create_tween()
		knockback_tween.tween_property(self,"knockback_vector",Vector2.ZERO,duration) 
		velocity = jump_vector
		await get_tree().create_timer(0.5).timeout
		jump_time = false
		


func _on_shoot_timer_timeout():
	jump_time = true
	_jump_move(Vector2(0,-900))
	await get_tree().create_timer(0.5).timeout
	set_physics_process(false)
	shoot_timer.stop()
	jump_timer.stop()
	for i in range(0,randi_range(15,25)):
		var projetile = projetile_scene.instantiate()
		projetile.global_position = get_tree().get_first_node_in_group('player').global_position + Vector2(50*randf_range(-2,2),randf_range(-600,-300))
		projetile.gravity = randf_range(60,150)
		get_tree().get_first_node_in_group("projetile").add_child(projetile)
		await get_tree().create_timer(randf_range(0.5,0.8)).timeout
	global_position.x = 300
	set_physics_process(true)
