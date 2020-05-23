extends Node2D


const Points = preload("res://Objects/Points.tscn")


var current_multiplier = 1
var current_score = 0
var current_points_per_brick = 10


func on_ball_lost():
	current_multiplier = 1
	current_points_per_brick = 10


func on_hit_paddle():
	current_multiplier = 1
	
	
func on_hit_brick(brick):
	var points = Points.instance()
	points.set_position(brick.get_global_position())
	points.set_multiplier(current_multiplier)
	points.set_points(current_points_per_brick)
	add_child(points)
	
	current_score += current_points_per_brick * current_multiplier
	$Counter.set_score(current_score)
	current_multiplier += 1
	current_points_per_brick += 10
