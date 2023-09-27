extends Node2D


@export var text = ''
@onready var label = $text_label
var player_inside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('interact') and player_inside:
		label.visible = !label.visible
		label.text = text
func _on_area_2d_body_entered(body):
	print("Entrou na area")
	print(Input.is_action_pressed('interact'))
	player_inside = true
	


func _on_area_2d_body_exited(body):
	label.visible = false
	player_inside = false
