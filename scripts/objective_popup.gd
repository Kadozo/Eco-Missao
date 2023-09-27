extends CanvasLayer


@export var text:String
@export var button_text:String
@onready var text_label = $Panel/text_label as Label
@onready var button = $Panel/Button as Button

# Called when the node enters the scene tree for the first time.
func _ready():
	text_label.text = text # Replace with function body.
	button.text = button_text


func _on_button_pressed():
	queue_free() # Replace with function body.
