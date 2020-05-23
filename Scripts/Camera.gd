extends Camera2D

export(NodePath) var bricks_path
export(int) var zoom_range = 300
export(float) var zoom_speed = 0.75

const origin := Vector2(640, 400)
const max_zoom := Vector2(0.5, 0.5)

var focus: Node2D
var bricks: Node2D
var target_zoom := Vector2.ONE


func _ready():
	bricks = get_node(bricks_path)


func focus_ball(node):
	if focus:
		focus.disconnect("tree_exited", self, "_remove_focus")
		
	focus = node
	focus.connect("tree_exited", self, "_remove_focus")
	
	
func _remove_focus():
	set_position(origin)
	target_zoom = Vector2.ONE
	focus = null
	

func _process(delta):
	target_zoom = Vector2.ONE
	
	if focus:
		set_position(focus.get_global_position())
		
		if bricks.get_child_count() == 1:
			var last_brick = bricks.get_children()[0]
			var distance_to_last_brick = focus.get_global_position().distance_to(last_brick.get_global_position())
			if distance_to_last_brick < zoom_range:
				var zoom_scale = distance_to_last_brick / zoom_range
				target_zoom = max_zoom.linear_interpolate(Vector2.ONE, clamp(zoom_scale, 0, 1))
				set_position(get_position().linear_interpolate(last_brick.get_global_position(), 0.5))
	
	set_zoom(get_zoom().move_toward(target_zoom, delta * zoom_speed))
		
