extends StaticBody2D

@onready var left = $left
@onready var middle = $midle
@onready var collision: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	Global.language_change.connect(change_language)
	left.position.x = -123.0
	middle.scale.x = 10.0
	middle.position.x = 0.0
	collision.scale.x = 3.6
	collision.position.x = 0.0
func change_language():
	#print(Global.Langs.keys()[Global.language])
	if Global.language == Global.Langs.English:
		left.position.x = -123.0
		middle.scale.x = 10.0
		middle.position.x = 0.0
		collision.scale.x = 3.6
		collision.position.x = 0.0
	elif Global.language == Global.Langs.German:
		left.position.x = -211.0
		middle.scale.x = 14.0
		middle.position.x = -42.0
		collision.scale.x = 4.85
		collision.position.x = -44.0
	elif Global.language == Global.Langs.Dutch:
		left.position.x = -173.0
		middle.scale.x = 12.2
		middle.position.x = -25.0
		collision.scale.x = 4.3
		collision.position.x = -26.0
	elif Global.language == Global.Langs.Polish:
		left.position.x = -156.0
		middle.scale.x = 11.5
		middle.position.x = -17.0
		collision.scale.x = 4.1
		collision.position.x = -17.0
func disable_collisions():
	collision.disabled = true
func enable_collisions():
	collision.disabled = false
