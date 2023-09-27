extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.player_is_dead:
		visible = true
		if !$GameoverFX.playing:
			$GameoverFX.play()
	else:
		visible = false
