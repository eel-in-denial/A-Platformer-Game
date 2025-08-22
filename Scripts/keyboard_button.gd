extends StaticBody2D

@export var broken = false
@export var is_unlocked = false
@export var action: String
@export var first_key: String
@onready var broken_sprite = $broken
@onready var box_l = $BoxL
@onready var box_m = $BoxM
@onready var box_r = $BoxR
@onready var key = $key
@onready var key_extras = $KeyboardExtras
@onready var collision = $CollisionShape2D
@onready var audio = $AudioStreamPlayer2D
var click = preload("res://Assets/SoupTonic UI1 SFX Pack 1 - ogg/SFX_UI_MenuSelections.ogg")
var assign = preload("res://Assets/SoupTonic UI1 SFX Pack 1 - ogg/SFX_UI_Confirm.ogg")

var change_mode = false
var wtfisgoingon = true
# Called when the node enters the scene tree for the first time.
var keys = ["Up", "Down", "Left", "Right", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "Period", "Comma", "Shift+Slash", "Slash", "BackSlash", "Semicolon", "Apostrophe", "BracketLeft", "BracketRight", "Equal", "Minus", "QuoteLeft"]
var keys_ex = ["Tab", "Escape", "empty", "Backspace", "Shift", "empty", "empty", "Enter", "Ctrl", "Alt", "Space", "empty", "Delete"]

var key_18 = {
	"centre" : 10.0,
	"middle_scale" : 6.0,
	"right_pos" : 50.0,
	"coll_scale" : 1.26
}

var key_20 = {
	"centre" : 14.0,
	"middle_scale" : 7.0,
	"right_pos" : 58.0,
	"coll_scale" : 1.37
}

var key_24 = {
	"centre" : 22.0,
	"middle_scale" : 8.0,
	"right_pos" : 74.0,
	"coll_scale" : 1.58
}

var key_28 = {
	"centre" : 30.0,
	"middle_scale" : 10.0,
	"right_pos" : 90.0,
	"coll_scale" : 1.79
}

var key_30 = {
	"centre" : 34.0,
	"middle_scale" : 10.2,
	"right_pos" : 98.0,
	"coll_scale" : 1.79
}

var presets = [key_24, key_18, key_28, key_28, key_28, key_20, key_20, key_28, key_24, key_18, key_30, key_18, key_18, key_18, key_18, key_28]

func _ready() -> void:
	if broken == true:
		broken_sprite.visible = true
		set_box_visibility(false)
		key.visible = false
		collision.disabled = true
	else:
		init_keys()
	box_l.frame = 1 if is_unlocked else 0
	box_m.frame = 1 if is_unlocked else 0
	box_r.frame = 1 if is_unlocked else 0
	
	

func init_keys():
	var key_pressed = keys.find(first_key)
	var key_pressed_ext = keys_ex.find(first_key)
	if key_pressed != -1:
		key.frame = key_pressed
		key.visible = true
		set_normal_key_size()
	elif key_pressed_ext != -1:
		key_extras.frame = key_pressed_ext
		key_extras.visible = true
		set_extra_key_size(key_pressed_ext)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_unlocked == false and body.is_in_group("player"):
		unlock()

func unlock():
	box_l.frame = 1
	box_r.frame = 1
	box_m.frame = 1
	is_unlocked = true
	
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and is_unlocked:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			change_key()
			audio.stream = click
			audio.play()

func change_key():
	change_mode = true
	key.visible = false
	key_extras.visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey and change_mode:
		if event.pressed:
			audio.stream = assign
			audio.play()
			var key_pressed = keys.find(event.as_text_keycode())
			var key_pressed_ext = keys_ex.find(event.as_text_keycode())
			if key_pressed != -1:
				key.frame = key_pressed
				key.visible = true
				set_normal_key_size()
			elif key_pressed_ext != -1:
				key_extras.frame = key_pressed_ext
				key_extras.visible = true
				set_extra_key_size(key_pressed_ext)
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
			change_mode = false
func set_normal_key_size():
	box_r.position.x = 30.0
	box_m.position.x = 0.0
	box_m.scale.x = 4.0
	collision.position.x = 0.0
	collision.scale.x = 1.0

func set_extra_key_size(i):
	box_r.position.x = presets[i]["right_pos"]
	box_m.position.x = presets[i]["centre"]
	box_m.scale.x = presets[i]["middle_scale"]
	key_extras.position.x = presets[i]["centre"]
	collision.position.x = presets[i]["centre"]
	collision.scale.x = presets[i]["coll_scale"]
func set_box_visibility(value):
	box_l.visible = value
	box_m.visible = value
	box_r.visible = value
func disable_collisions():
	collision.disabled = true
func enable_collisions():
	if broken == false:
		collision.disabled = false
