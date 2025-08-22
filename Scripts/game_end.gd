extends StaticBody2D

@export var root: Node2D
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var area_coll = $Area2D/CollisionShape2D
var unlocked = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.frame = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		unlocked = true
		sprite.frame = 0


func _on_button_pressed() -> void:
	if unlocked == true:
		root.slide_back()
		root.playable = true
func disable_collisions():
	collision.disabled = true
	area_coll.disabled = true
	
func enable_collisions():
	collision.disabled = false
	area_coll.disabled = false
