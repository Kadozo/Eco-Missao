extends CharacterBody2D


const SPEED = 2900.0
var direction = -1
var player_near = false
var player_distance
@onready var animation = $animation
@onready var hit_fx = $hitFX

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if direction > 0:
		animation.flip_h = true
	else:
		animation.flip_h = false
		
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if player_near:
		velocity.x = direction * SPEED * delta
	else:
		velocity.x = 0
	move_and_slide()
	_set_state()


func _on_player_detector_body_entered(body):
	if body.name == 'Player':
		player_distance = body.global_position.x - position.x
		if player_distance > 0:
			direction = 1
		else:
			direction = -1
		player_near = true


func _on_player_detector_body_exited(body):
	if body.name == 'Player':
		print('saiu')
		player_near = false

func _set_state():
	var state = "idle"
	if velocity.x != 0:
		state = "run"
	if animation.animation != state:
		print(state)
		animation.play(state)


func _on_animation_animation_finished():
	await get_tree().create_timer(0.3).timeout
	queue_free()
