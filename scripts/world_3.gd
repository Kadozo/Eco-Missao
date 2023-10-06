extends Node2D

@onready var player = $Player
@onready var camera = $camera
@onready var boss_fireball = $Boss_fireball
@onready var boss_music = $bossMusic as AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.level = 3
	boss_fireball.set_physics_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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


func _on_boss_fight_area_entered_body_entered(body):
	if body.name == "Player":
		start_boss_fight()
		$boss_fight_area_entered.queue_free()

func start_boss_fight():
	$color_world/AnimationPlayer.play("fade")
	boss_fireball.set_physics_process(true)
	$bossMusic.play()


func _on_boss_fireball_phase_two():
	boss_music.pitch_scale = 1.3
	$color_world/AnimationPlayer.play("fade_two")


func _on_boss_fireball_boss_defeat():
	$bossMusic.stop()
	$color_world/AnimationPlayer.play("fade_out")
	await get_tree().create_timer(4).timeout
	TransitionScreen.fade_in("res://levels/contextualização_3_4.tscn")
