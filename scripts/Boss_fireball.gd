extends CharacterBody2D


var SPEED = 3500.0
const JUMP_VELOCITY = -400.0
var life = 40

@onready var hp_bar = $CanvasLayer/HP_BAR as TextureProgressBar
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
@onready var hit_fx = $hitFX

signal boss_defeat
signal phase_two

func _ready():
	hp_bar.max_value = life
	hp_bar.global_position.x = 860
	hp_bar.value = life

func _physics_process(delta):
	hp_bar.visible = true
	if life < 0:
		queue_free()
		boss_defeat.emit()
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
	_phase_two()

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
	_jump_move(Vector2((SPEED/35)*direction,-500),0.25)

func _jump_move(jump_force = Vector2.ZERO, duration = 0.25):
	if jump_force != Vector2.ZERO:
		jump_vector = jump_force
		var knockback_tween = get_tree().create_tween()
		knockback_tween.tween_property(self,"knockback_vector",Vector2.ZERO,duration) 
		velocity = jump_vector
		await get_tree().create_timer(0.5).timeout
		jump_time = false
		
func _phase_two():
	if life <= 20:
		phase_two.emit()
		SPEED = 5000
		animation.modulate = Color(1,0.6,0.5,1)
		jump_timer.wait_time = 1.7

func _on_shoot_timer_timeout():
	jump_time = true
	_jump_move(Vector2(0,-900))
	await get_tree().create_timer(0.5).timeout
	set_physics_process(false)
	shoot_timer.stop()
	jump_timer.stop()
	for i in range(0,randi_range(20,30)):
		var projetile = projetile_scene.instantiate()
		var projetile2 = projetile_scene.instantiate()
		var projetile3 = projetile_scene.instantiate()
		projetile.global_position = get_tree().get_first_node_in_group('player').global_position + Vector2(30*randi_range(-2,2),-600)
		projetile.gravity = randf_range(60,150)
		projetile2.global_position = get_tree().get_first_node_in_group('player').global_position + Vector2(30*randi_range(-2,2),-600)
		projetile2.gravity = randf_range(60,150)
		get_tree().get_first_node_in_group("projetile").add_child(projetile)
		get_tree().get_first_node_in_group("projetile").add_child(projetile2)
		await get_tree().create_timer(randf_range(0.3,0.5)).timeout
	global_position.x = 300
	set_physics_process(true)


func _on_animated_sprite_2d_animation_finished():
		set_physics_process(true)
		life -= 1
		hp_bar.value = life
