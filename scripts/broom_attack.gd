extends Area2D





func _on_area_entered(area):
		if area.name == "hitbox":
			area.owner.set_physics_process(false)
			area.owner.animation.play('hurt')
			area.owner.hit_fx.play()
