extends Area2D

@onready var animation = $AnimatedSprite2D as AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == 'Player':
		Global.player_is_holding_bucket_water = true
		animation.play('collected')


func _on_animated_sprite_2d_animation_finished():
	queue_free()
