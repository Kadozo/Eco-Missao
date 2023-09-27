extends CharacterBody2D


const SPEED = 2500
const JUMP_VELOCITY = -400.0

@onready var collision_detector = $collision_detector as RayCast2D
@onready var collision_detector_2 = $collision_detector2
@onready var collision_detector_3 = $collision_detector3
@onready var collision_detector_4 = $collision_detector4

@onready var animation = $AnimatedSprite2D as AnimatedSprite2D
@onready var tree = preload("res://prefabs/planted_tree.tscn") as PackedScene
@onready var hit_fx = $hitFX

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 

var direction = -1

func _physics_process(delta):
	# Add the gravity.,
	if not is_on_floor():
			velocity.y += gravity * delta
	if collision_detector.is_colliding() or collision_detector_2.is_colliding() or collision_detector_3.is_colliding() or collision_detector_4.is_colliding():
		direction = direction * -1
		collision_detector.scale.x *= -1 
		collision_detector_2.scale.x *= -1 
		collision_detector_3.scale.x *= -1 
		collision_detector_4.scale.x *= -1 
		animation.scale.x *= -1
	velocity.x = direction * SPEED * delta
	

	move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	queue_free()
	Global.planted_trees += 1
	Global.score += 220
	var planted_tree = tree.instantiate()
	planted_tree.global_position = global_position + Vector2(0,-20)
	$"/root/Hud/Holder-Contagem_Regressiva/Label".set_timer(Global.timer + 10)
	get_tree().get_first_node_in_group("trees").add_child(planted_tree)
