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
