extends Button

@export var path:String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	$buttonFX.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(path) # Replace with function body.
