extends Node2D

var next_scene = "res://levels/contextualização_1_2.tscn"
@onready var player = $Player as CharacterBody2D
@onready var camera = $camera as Camera2D

var finish_level = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$bgMusic.play()
	player.follow_camera(camera)
	Global.level = 1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.timer <= 30 and Global.timer > 20:
		$bgMusic.pitch_scale = 1.3
	elif Global.timer <= 20 and Global.timer > 10:
		$bgMusic.pitch_scale = 1.5
	elif Global.timer <= 10:
		$bgMusic.pitch_scale = 1.7
	else:
		$bgMusic.pitch_scale = 1
	if Global.timer <= 0:
		if !Global.player_is_dead:
			$Player/animation.play("hurt")
			$Reset_Timer.start(0)
			$bgMusic.stop()
			player.player_is_dead = true
	if Global.items_received >= 20 and !finish_level:
		finish_level = true
		Global.timer_aux = Global.timer + 40
		Global.level = 2
		$"/root/Hud/Holder-Contagem_Regressiva/Label".set_timer(Global.timer_aux)
		TransitionScreen2.fade_in(next_scene)
		

func _on_reset_timer_timeout():
		$"/root/Hud/Holder-Contagem_Regressiva/Label".timer_reset()
		Global.reset_hud()
		Global.items_received = 0
		get_tree().reload_current_scene()
		$Reset_Timer.stop()
		player.player_is_dead = false
		Global.player_is_dead = false


func _on_player_player_dead():
	Global.player_is_dead = true # Replace with function body.
