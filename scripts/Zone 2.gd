extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	Global.restant = 5


func _process(delta):
	if Global.restant ==0:
		Global.goto_scene("res://scenes/Zone 3.tscn")
