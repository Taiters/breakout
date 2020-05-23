extends RigidBody2D

signal lost(position)
signal hit_brick(brick)
signal hit_paddle

export(int) var start_speed := 200
export(int) var increase_per_hit := 25
export(float, 0, 1) var paddle_bounce_influence := 0.5

var speed: int
var paddle_node: Node2D
var nearest_brick: Node2D
var nearby_bricks := []

var lost = false


func _ready():
	paddle_node = get_parent().get_node("Paddle")
	speed = start_speed
	set_linear_velocity(Vector2(0, speed))
	

func _process(delta):
	if !lost and get_position().y > get_viewport_rect().end.y:
		lost = true
		emit_signal("lost", get_position())
		
		$No.play()
		yield($No, "finished")
		
		queue_free()


func _look_at(node):
	var direction = get_global_position().direction_to(node.get_global_position())
	$Pupils.set_position(direction * Vector2(1, 2))


func _integrate_forces(state):
	var current_speed := get_linear_velocity().length()
	
	for colliding_body in get_colliding_bodies():
		if colliding_body == paddle_node:
			speed += increase_per_hit
			var paddle_anchor = paddle_node.get_node("Anchor")
			var paddle_bounce_direction = (get_position() - paddle_anchor.get_global_position()).normalized()
			var new_direction := get_linear_velocity().normalized().slerp(paddle_bounce_direction, paddle_bounce_influence)

			set_linear_velocity(new_direction.normalized() * max(current_speed, speed))
			emit_signal("hit_paddle")
			
		elif colliding_body.is_in_group("Bricks"):
			speed += increase_per_hit
			colliding_body.queue_free()
			$Screams.play_scream()
			emit_signal("hit_brick", colliding_body)
			

	if current_speed > speed:
		set_linear_damp(0.25)
	else:
		set_linear_damp(0)
		
	if abs(get_linear_velocity().y) < 30:
		set_gravity_scale(2)	
	elif get_position().y > paddle_node.get_position().y:
		set_gravity_scale(4)
	else:
		set_gravity_scale(0)
		
	if get_linear_velocity().length() > 400:
		$Trail.set_emitting(true)
	else:
		$Trail.set_emitting(false)
		
		
	$Ray.set_cast_to(get_linear_velocity() * 3)
	var brick = $Ray.get_collider()
	if brick:
		_look_at(brick)
		brick.scream()
	else:
		$Pupils.set_position(Vector2.ZERO)

