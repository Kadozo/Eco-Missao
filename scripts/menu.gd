extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	$buttonFX.play()
	await get_tree().create_timer(0.1).timeout
	TransitionScreen2.fade_in("res://levels/prólogo.tscn")
	pass # Replace with function body.


func _on_controls_button_pressed():
	$buttonFX.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://prefabs/controls_screen.tscn")
	pass # Replace with function body.


func _on_credits_button_pressed():
	$buttonFX.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://prefabs/credits_screen.tscn")


func _on_quit_button_pressed():
	$buttonFX.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()


func _on_made_by_button_pressed():
	OS.shell_open("https://github.com/Kadozo")
