extends Area2D

func _on_body_entered(body):
	if body.name == 'seed_projetile':
		body.queue_free()
		owner.set_physics_process(false)
		owner.animation.play('hurt')
		owner.hit_fx.play()
		owner.collision_layer = 0
