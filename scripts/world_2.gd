extends Node2D

@onready var planted_tree := preload("res://prefabs/planted_tree.tscn")
@onready var player = $Player as CharacterBody2D
@onready var camera = $camera as Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player.follow_camera(camera)
	Global.level = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.timer <= 0:
		if !Global.player_is_dead:
			$Player/animation.play("hurt")
			$Reset_Timer.start(0)
			player.player_is_dead = true


func _on_player_player_dead():
	Global.player_is_dead =  true
	player.player_is_dead = true
	await get_tree().create_timer(3).timeout
	$"/root/Hud/Holder-Contagem_Regressiva/Label".set_timer(40)
	get_tree().reload_current_scene()
	if Global.score >= 2000:
		Global.score -= -2000
	else: 
		Global.score = 0
	player.player_is_dead = false
	Global.player_is_dead = false


func _on_reset_timer_timeout():
	$"/root/Hud/Holder-Contagem_Regressiva/Label".set_timer(40)
	get_tree().reload_current_scene()
	$Reset_Timer.stop()
	player.player_is_dead = false
	Global.player_is_dead = false


func _on_level_finish_body_entered(body):
	if body.name == "Player":
		player.player_life = 3
		Global.score_checkpoint = Global.score
		TransitionScreen2.fade_in("res://prefabs/planted_tree.tscn")
