extends StaticBody2D

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
var is_unlocked = false
var toggled = false

func _ready() -> void:
	sprite.frame = 0

func unlock():
	sprite.frame = 1
	is_unlocked = true

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and is_unlocked:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			toggle()

func toggle():
	toggled = !toggled
	sprite.frame = 3 if toggled else 1


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		unlock()
func disable_collisions():
	collision.disabled = true
func enable_collisions():
	collision.disabled = false
