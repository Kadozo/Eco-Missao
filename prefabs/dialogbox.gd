extends NinePatchRect

@onready var text = $MarginContainer/Text as RichTextLabel
@onready var timer = $Timer

@export var msg_queue: Array[String] = []

func _ready():
	show_message()

func _input(event):
	if event is InputEventKey and event.is_action_pressed("interact"):
		$press_F.visible = false
		show_message() # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_message():
	if text.visible_characters < text.text.length():
		text.visible_characters = text.text.length()
		return
	if msg_queue.size() == 0:
		hide()
		return
	var msg: String = msg_queue[0]
	text.visible_characters = 0
	text.text = msg
	timer.start()

func _on_timer_timeout():
	if $textFX.playing:
		$textFX.stop()
	$textFX.play()
	if text.visible_characters == text.text.length():
		$press_F.visible = true
		msg_queue.pop_front()
		timer.stop()
	text.visible_characters += 1 # Replace with function body.
	
