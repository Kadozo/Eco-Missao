extends Area2D

func _on_body_entered(body):
	if body.name == 'seed_projetile' or body.name == 'water_projetile' or body.name == 'broom_attack':
		body.queue_free()
		owner.set_physics_process(false)
		owner.animation.play('hurt')
		owner.hit_fx.play()
