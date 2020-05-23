extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var Main = preload("res://Scenes/Main.tscn")
var transitioning = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.animation_set_next("Title", "Hover")
	$AnimationPlayer.play("Title")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !transitioning && Input.is_action_pressed("ui_select"):
		transition()


func transition():
	if !transitioning:
		transitioning = true
		$AnimationPlayer.play("Transition")
		get_node("/root/Global").start_music()
	
	
func start_main():
	get_tree().change_scene_to(Main)
