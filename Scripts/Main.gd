extends Node2D


signal spawned_ball(Node2D)
signal ball_lost
signal time_scale_changed


const Ball := preload("res://Objects/Ball.tscn")
const BallExplosion := preload("res://Objects/BallExplosion.tscn")


var ball: Node2D
var time_scale = Engine.time_scale


func _ready():
	spawn_ball()
	
	
func handle_lost_ball(position):
	emit_signal("ball_lost")
	
	var explosion = BallExplosion.instance()
	explosion.set_position(position)
	add_child(explosion)
	$Splatter.add_splatter(position.x)
	$Score.on_ball_lost()
	
	yield(explosion, "finished")
	spawn_ball()


func spawn_ball():
	ball = Ball.instance()
	
	ball.set_position($BallSpawn.get_position())
	ball.connect("lost", self, "handle_lost_ball")
	ball.connect("hit_paddle", $Score, "on_hit_paddle")
	ball.connect("hit_brick", $Score, "on_hit_brick")
	
	$Camera.focus_ball(ball)
	
	add_child(ball)
	emit_signal("spawned_ball", ball)
	
	
func _process(delta):
	if ball and is_instance_valid(ball) and $Bricks.get_child_count() == 1:
		var last_brick = $Bricks.get_children()[0]
		var distance = ball.get_global_position().distance_to(last_brick.get_global_position())
		if distance < 200:
			var t = 1 - distance / 200
			var s = 1 * (.9 - t) + 0.1 * t
			time_scale = s
			last_brick.scream()
		else:
			time_scale = 1
	else:
		time_scale = 1
		
	if $Bricks.get_child_count() == 0:
		$AnimationPlayer.play("End")
			
	
	if Engine.time_scale != time_scale:
		Engine.time_scale = time_scale		
		emit_signal("time_scale_changed")
		

func start_end():
	get_tree().change_scene("res://Scenes/End.tscn")
