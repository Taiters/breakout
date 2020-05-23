extends Node2D


export(int, 1, 8) var rows := 4
export(int, 1, 8) var columns := 7

const BRICK_WIDTH := 128
const BRICK_HEIGHT := 64

const Brick := preload("res://Objects/Brick.tscn")

var rtt: Viewport


func _ready():
	var total_width := columns * BRICK_WIDTH
	var left := BRICK_WIDTH / 2 - total_width / 2
	
	for i in range(rows):
		var y := i * BRICK_HEIGHT
		for j in range(columns):
			var x := left + j * BRICK_WIDTH
			var brick := Brick.instance()
			brick.set_position(Vector2(x, y))
			add_child(brick)
