extends CanvasLayer

signal start_game

@onready var animation = get_node("Animation")
var target_level = String()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fade_in(level):
	target_level = level
	animation.play("fade_in")	
func _on_animation_animation_finished(anim_name):
	if anim_name == "fade_in":
		get_tree().change_scene_to_file(target_level)
		animation.play("fade_out")
	elif anim_name == "fade_out":
		emit_signal("start_game")
