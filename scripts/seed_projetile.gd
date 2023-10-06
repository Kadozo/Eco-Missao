extends CharacterBody2D


var speed = 200  # Velocidade da bala em pixels por segundo
var direction = 1  # Direção da bala
var life_time = 1

func _physics_process(delta):
	scale.x = direction.normalized().x
	velocity = direction.normalized() * speed
	move_and_collide(velocity * delta)
	life_time -= delta
	if life_time < 0:
		queue_free()
