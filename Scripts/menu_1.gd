extends Node2D


# Called when the node enters the scene tree for the first time.
func disable_collisions():
	for child in get_children():
		if child is StaticBody2D:
			child.disable_collisions()

func enable_collisions():
	for child in get_children():
		if child is StaticBody2D:
			child.enable_collisions()
