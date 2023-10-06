extends CanvasLayer

@onready var dialogbox = $Dialogbox
@onready var next_scene_path = "res://levels/world_4.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dialogbox.msg_queue.is_empty():
		if Input.is_action_just_pressed("interact"):
			Global.level = 4
			$"/root/Hud/Holder-Contagem_Regressiva/Label".set_timer(45)
			TransitionScreen.fade_in(next_scene_path)
