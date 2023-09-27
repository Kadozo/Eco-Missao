extends Label

@export var countdown_time = 60
var reset
@onready var texture_progress_bar = $"../TextureProgressBar"

# Called when the node enters the scene tree for the first time.
func _ready():
	reset = countdown_time # Replace with function body.
	texture_progress_bar.min_value = 0
	texture_progress_bar.max_value = countdown_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countdown_time -= delta
	if(Global.timer != int(countdown_time)):
		Global.timer = int(countdown_time)
		update_display(Global.timer)

func update_display(time):
	text = str(time)
	print(time)
	texture_progress_bar.value = time
	
func timer_reset():
	countdown_time = reset
func set_timer(time):
	countdown_time = time
