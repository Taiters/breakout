extends Node2D


var points setget set_points
var multiplier setget set_multiplier


# Called when the node enters the scene tree for the first time.
func _ready():
	var text = str(points)
	if multiplier > 1:
		text = text + " X " + str(multiplier)
		
	$Container/Label.set_text(text)
	$AnimationPlayer.play("Move")


func set_points(new_points):
	points = new_points

func set_multiplier(new_multiplier):
	multiplier = new_multiplier
