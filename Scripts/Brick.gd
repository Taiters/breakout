extends StaticBody2D


var screaming = false


func _ready():
	var main = get_tree().get_root().get_node("Main")
	main.connect("time_scale_changed", self, "_handle_time_scale_changed")


func _handle_time_scale_changed():
	$NoScream.set_speed_scale(Engine.time_scale)
	$NoSound.set_pitch_scale(Engine.time_scale)


func scream():
	if !screaming:
		screaming = true
		$NoScream.play("NoScream")
		

func _on_NoScream_animation_finished(anim_name):
	screaming = false
