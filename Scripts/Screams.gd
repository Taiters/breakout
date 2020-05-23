extends Node


signal all_screams_finished


var available_screams = []


func _ready():
	for scream in get_children():
		scream.connect("finished", self, "_scream_finished", [scream])
		available_screams.append(scream)
		
		
func _scream_finished(scream):
	available_screams.append(scream)
	

func play_scream():
	if available_screams.empty():
		return
		
	var scream = available_screams[randi() % available_screams.size()]
	available_screams.erase(scream)
	scream.play()
	
