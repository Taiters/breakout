extends Node2D


export(Texture) var splatter_texture
export(Color) var splatter_color



func add_splatter(x):
	var splat = Sprite.new()
	splat.set_scale(Vector2(0.125, 0.125))
	splat.set_rotation_degrees(randi() % 360)
	splat.set_texture(splatter_texture)
	splat.set_position(Vector2(x, 0))
	splat.set_modulate(splatter_color)
	
	add_child(splat)
