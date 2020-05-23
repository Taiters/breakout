extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$AnimationPlayer.play("End")


func start_splash():
	get_tree().change_scene("res://Scenes/Splash.tscn")
