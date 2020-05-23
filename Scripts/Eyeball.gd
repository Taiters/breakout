extends Node2D


var focus: Node2D
var watching := true

func _ready():
	var main = get_tree().get_root().get_node("Main")
	
	main.connect("spawned_ball", self, "attach_ball")
	main.connect("ball_lost", self, "remove_ball")
	
	
func attach_ball(ball):
	focus = ball
	
func remove_ball():
	focus = null
	

func watch():
	watching = true


func _process(delta):
	if focus and watching:
		var direction = get_global_position().direction_to(focus.get_global_position())
		$Pupil.set_position(direction * 4)
