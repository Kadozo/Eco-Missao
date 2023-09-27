extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Score: " + str(Global.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "Score: " + str(Global.score)
