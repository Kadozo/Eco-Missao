extends Sprite2D
# {1: "PLASTICO",2: "PAPEL",3: "METAL",4: "VIDRO",5: "NÃO RECICLÁVEL"}
@export var type = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false 
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match type:
		1:
			if Global.player_is_holding_recycle_item and Global.plastic > 0:
				visible = true
		2:
			if Global.player_is_holding_recycle_item and Global.paper > 0:
				visible = true
		3:	
			if Global.player_is_holding_recycle_item and Global.metal > 0:
				visible = true
		4:
			if Global.player_is_holding_recycle_item and Global.glass > 0:
				visible = true
		5:
			pass
	if !Global.player_is_holding_recycle_item:
		visible = false
