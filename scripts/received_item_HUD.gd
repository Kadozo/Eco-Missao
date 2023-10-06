extends Label

var item_received = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match Global.level:
		1:
			if Global.items_received != item_received:
				item_received = Global.items_received
				text = "Lixo coletado: " + str(item_received) + "/20"
		2:
			text = "Árvores Plantadas: " + str(Global.planted_trees)
		3:
			text = "Derrote o elemental de fogo"
		_:
			text = ""
