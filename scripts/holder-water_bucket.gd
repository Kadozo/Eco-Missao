extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.player_is_holding_bucket_water and Global.level == 3:
		visible=true
	else:
		visible=false
