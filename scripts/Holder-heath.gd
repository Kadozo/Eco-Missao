extends Control
@onready var heath_1 = $Heath_1
@onready var heath_2 = $Heath_2
@onready var heath_3 = $Heath_3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		fill_health(Global.player_health)
	

func fill_health(number:int):
	if number == 3:
		heath_1.play('fill')
		heath_2.play('fill')
		heath_3.play('fill')
	if number == 2:
		heath_1.play('fill')
		heath_2.play('fill')
		heath_3.play('hollow')
	if number == 1:
		heath_1.play('fill')
		heath_2.play('hollow')
		heath_3.play('hollow')
	if number == 0:
		heath_1.play('hollow')
		heath_2.play('hollow')
		heath_3.play('hollow')
		
