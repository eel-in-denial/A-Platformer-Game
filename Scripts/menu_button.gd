extends StaticBody2D

@export var menu: Node2D
@export var type := 1
@onready var sprite_1 = $mb1
@onready var sprite_2 = $mb2
@onready var collision = $CollisionShape2D
@onready var area = $Area2D
@onready var text = $Text
var curr_sprite: Sprite2D
var unlocked = false:
	set(value):
		unlocked = value
		if unlocked:
			curr_sprite.frame = 0
		else:
			curr_sprite.frame = 2
var toggled = false:
	set(value):
		toggled = value
		if toggled:
			curr_sprite.frame = 0
		else:
			curr_sprite.frame = 3

var root: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	root = get_parent() # this is so illegal
	if type == 1:
		menu_1_init()
	elif type == 2:
		menu_2_init()
	else:
		menu_3_init()
	text.text = text.english


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func menu_1_init():
	sprite_1.visible = true
	sprite_2.visible = false
	curr_sprite = sprite_1
	collision.scale.x = 1.0
	area.scale.x = 1.0
	text.english = "Gameplay"
	text.german = "Spielweise"
	text.dutch = "Gameplay"
	text.polish = "Rozgrywka"
	unlocked = true
func menu_2_init():
	sprite_1.visible = false
	sprite_2.visible = true
	curr_sprite = sprite_2
	collision.scale.x = 1.42
	area.scale.x = 1.42
	text.english = "Audio/Visual"
	text.german = "Audio/Visuell"
	text.dutch = "Audio/Visueel"
	text.polish = "Audio/Wizualne"
	unlocked = false
func menu_3_init():
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_feet"):
		root.hide_all_menus()
		menu.visible = true
		menu.enable_collisions.call_deferred()
		unlocked = true
