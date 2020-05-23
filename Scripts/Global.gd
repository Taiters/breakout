extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var music_playing = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func increase_speed():
	while music_playing:
		yield(get_tree().create_timer(10), "timeout")
		$AudioStreamPlayer.set_pitch_scale($AudioStreamPlayer.get_pitch_scale() + (randf() * 0.05 - 0.024))
	


func start_music():
	if !music_playing:
		music_playing = true
		$AudioStreamPlayer.play()
	
	increase_speed()
