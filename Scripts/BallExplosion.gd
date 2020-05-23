extends Particles2D


signal finished


func _ready():
	set_emitting(true)


func _on_Timer_timeout():
	emit_signal("finished")
	queue_free()
