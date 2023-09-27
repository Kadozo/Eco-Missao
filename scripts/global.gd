extends Node

var level = 0

var timer
var timer_aux
var score = 0

var score_checkpoint = 0


var plastic = 0
var paper = 0
var glass = 0
var metal = 0
var items_received = 0
var planted_trees = 0
var seeds = 30

var player_health = 0

var player_is_dead = false

var player_is_holding_recycle_item = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_hud():
	score = 0
	plastic = 0
	paper = 0
	glass = 0
	metal = 0
	
