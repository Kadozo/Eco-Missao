extends Area2D

var collected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == 'Player' and !collected:
		collected = true
		$animation.play("collect")
		Global.score += 1 * 200
		$collectFX.play()


func _on_animation_animation_finished():
	queue_free()
