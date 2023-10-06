extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity:float 


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 2  
	move_and_slide()



func _on_life_timer_timeout():
	queue_free() # Replace with function body.


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		await get_tree().create_timer(0.2).timeout
		queue_free()
