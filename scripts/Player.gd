extends CharacterBody2D

 # A cena do elemento a ser spawnado

var SPEED = 150.0
var JUMP_FORCE = -400.0
var player_life = 3
var is_hurt = false
var player_is_dead = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
var knockback_vector = Vector2.ZERO

@onready var animation := $animation as AnimatedSprite2D
@onready var spawn_point = global_position
@onready var remote_transform = $RemoteTransform2D as RemoteTransform2D

var bullet_scene = preload("res://prefabs/seed_projetile.tscn")  # Caminho para o Scene da bala
var shoot_timer = 0.5  # Intervalo de disparo em segundos
var can_shoot = false
var direction

signal player_dead

func _physics_process(delta):
	Global.player_health = player_life
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		is_jumping = false
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and !is_jumping:
		velocity.y = JUMP_FORCE
		is_jumping = true
		$jumpFX.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed('interact') and can_shoot:
		shoot(animation.scale.x)
		

	if !can_shoot and get_parent().name == 'World2':
		shoot_timer -= delta
		if shoot_timer <= 0:
			can_shoot = true
			shoot_timer = 0.7
			
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	move_and_slide()
	_set_state()
	
	if player_is_dead:
		set_physics_process(false)
		player_dead.emit()

func shoot(direction):
	var bullet = bullet_scene.instantiate()  # Cria uma nova instância da bala
	bullet.global_position = global_position + Vector2(10,-15)  # Define a posição inicial da bala
	bullet.direction = Vector2(direction, 0)  # Define a direção da bala (ajuste conforme necessário)
	get_parent().add_child(bullet)  # Adiciona a bala como um filho do nível

	can_shoot = false  # Define a flag para impedir disparos frequentes
	


func _on_hurtbox_body_entered(body):
	if body.is_in_group('enemies'):
		$hurtFX.play()
		if player_life <= 0:
			player_is_dead = true
			player_dead.emit()
		else:
			if $RayCastRight.is_colliding():
				take_damage(Vector2(-350,-200))
			elif $RayCastLeft.is_colliding():
				take_damage(Vector2(350,-200))
			else:
				take_damage(Vector2(0,-400))
func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path= camera_path

func take_damage(knockback_force = Vector2.ZERO, duration = 0.25):
	player_life -= 1
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		var knockback_tween = get_tree().create_tween()
		knockback_tween.parallel().tween_property(self,"knockback_vector",Vector2.ZERO,duration) 
		animation.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1),duration)
	is_hurt = true
	await get_tree().create_timer(0.3).timeout
	is_hurt = false

func _set_state():
	var state = "idle"
	if !is_on_floor():
		state = "jump"
	if direction != 0 and is_on_floor():
		state = "run"
	if is_hurt or player_is_dead:
		state = "hurt"
	if animation.name != state:
		animation.play(state)
