extends Area2D
# {0: "MOEDA",1: "PLASTICO",2: "PAPEL",3: "METAL",4: "VIDRO",5: "NÃO RECICLÁVEL"}
@export var type = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	match type:
		0:
			$animation.play("idle_moeda")
		1:
			$animation.play("idle_plastico")
		2:
			$animation.play("idle_papel")
		3:
			$animation.play("idle_metal")
		4:
			$animation.play("idle_vidro")
		5:
			pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	match type:
		0:
			$animation.play("collect_moeda")
		1:
			if !Global.player_is_holding_recycle_item:
				$animation.play("collect_item")
				Global.plastic += 1
				Global.player_is_holding_recycle_item = true
		2:
			if !Global.player_is_holding_recycle_item:
				$animation.play("collect_item")
				Global.paper += 1
				Global.player_is_holding_recycle_item = true
		3:
			if !Global.player_is_holding_recycle_item:
				$animation.play("collect_item")
				Global.metal += 1
				Global.player_is_holding_recycle_item = true
		4:
			if !Global.player_is_holding_recycle_item:
				$animation.play("collect_item")
				Global.glass += 1
				Global.player_is_holding_recycle_item = true
		5:
			pass


func _on_animation_animation_finished():
	queue_free()
