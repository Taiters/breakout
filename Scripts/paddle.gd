extends KinematicBody2D


export(int) var speed = 400


func get_input_direction():
	var velocity = Vector2()
	
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
		
	return velocity
	

func _physics_process(delta):
	move_and_slide(get_input_direction() * speed)
