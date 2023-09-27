extends Area2D
# {1: "PLASTICO",2: "PAPEL",3: "METAL",4: "VIDRO",5: "NÃO RECICLÁVEL"}
@export var type = 1
var player_inside = false

@onready var legenda = $Panel/Legenda
@onready var panel = $Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	match type:
		1:
			$animation.play("lixeira_plastico")
			legenda.text = "Plástico"
		2:
			$animation.play("lixeira_papel")
			legenda.text = "Papel"
		3:
			$animation.play("lixeira_metal")
			legenda.text = "Metal"
		4:
			$animation.play("lixeira_vidro")
			legenda.text = "Vidro"
		5:
			pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('interact') and player_inside and Global.player_is_holding_recycle_item:
		match type:
			1:
				if Global.plastic > 0:
					Global.score += 1 * 80
					Global.plastic -= 1
					Global.items_received += 1
					Global.player_is_holding_recycle_item = false
					$"/root/Hud/Holder-Contagem_Regressiva/Label".set_timer(Global.timer + 15)
					$confirmFX.play()
			2:
				if Global.paper > 0:
					Global.paper -= 1
					Global.score += 1 * 60
					Global.items_received += 1
					Global.player_is_holding_recycle_item = false
					$"/root/Hud/Holder-Contagem_Regressiva/Label".set_timer(Global.timer + 15)
					$confirmFX.play()
			3:
				if Global.metal > 0:
					Global.metal -= 1
					Global.score += 1 * 160
					Global.items_received += 1
					Global.player_is_holding_recycle_item = false
					$"/root/Hud/Holder-Contagem_Regressiva/Label".set_timer(Global.timer + 15)
					$confirmFX.play()
			4:
				if Global.glass > 0:
					Global.glass -= 1
					Global.score += 1 * 120
					Global.items_received += 1
					Global.player_is_holding_recycle_item = false
					$"/root/Hud/Holder-Contagem_Regressiva/Label".set_timer(Global.timer + 15)
					$confirmFX.play()
			5:
				pass


func _on_body_entered(body):
	panel.visible = true
	player_inside = true


func _on_body_exited(body):
	panel.visible = false
	player_inside = false # Replace with function body.
