extends Node2D

@onready var player = $Player
@onready var camera = $camera

# Called when the node enters the scene tree for the first time.
func _ready():
	player.follow_camera(camera)
	Global.level = 4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_level_finish_body_entered(body):
	if body.name == "Player":
		player.player_life = 3
		Global.score_checkpoint = Global.score
		TransitionScreen2.fade_in("res://levels/final.tscn")
