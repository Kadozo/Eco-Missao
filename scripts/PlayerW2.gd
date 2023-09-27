extends CharacterBody2D


var SPEED = 250.0
var JUMP_FORCE = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
@onready var animation := $animation as AnimatedSprite2D

func _physics_process(delta):
	if Global.player_is_dead:
		SPEED = 0
		JUMP_FORCE = 0
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
			animation.play("jump")
		else:
			is_jumping = false
		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_FORCE
			is_jumping = true

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = 1
		if direction:
			velocity.x = direction * SPEED
			animation.scale.x = direction
			if is_jumping:
				animation.play("jump")
			else:
				animation.play("run")
			
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_jumping:
				animation.play("jump")
			else:
				animation.play("idle")

		move_and_slide()
