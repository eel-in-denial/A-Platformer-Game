extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player
@onready var hint = $error
@onready var audio = $AudioStreamPlayer
@export var menus: Array[Node2D]
@onready var buttons = [$exit, $play, $settings]
@onready var credits = $Credits
@onready var dividor = $Border/dividor

var blocked_click = preload("res://Assets/SoupTonic UI1 SFX Pack 1 - ogg/SFX_UI_Cancel.ogg")
var click = preload("res://Assets/SoupTonic UI1 SFX Pack 1 - ogg/SFX_UI_MenuSelections.ogg")
var click_2 = preload("res://Assets/SoupTonic UI1 SFX Pack 1 - ogg/SFX_UI_OpenMenu.ogg")
var exit_click = preload("res://Assets/SoupTonic UI1 SFX Pack 1 - ogg/SFX_UI_Exit.ogg")
var move_right = false
var move_left = false
var play_clicked = 0
var playable = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_all_menus()
	menus[0].visible = true
	menus[0].enable_collisions.call_deferred()
	camera.position = Vector2(-576.0, 356.0)
	player.opening_screen()

func _physics_process(delta: float) -> void:
	if move_right == true:
		camera.position = lerp(camera.position, Vector2(580.0, 356.0), .05)
		if camera.position.x > 576.0:
			camera.position = Vector2(576.0, 356.0)
			move_right = false
			player.walk_to_screen()
	if move_left == true:
		camera.position = lerp(camera.position, Vector2(-580.0, 356.0), .05)
		if camera.position.x < -576.0:
			camera.position = Vector2(-576.0, 356.0)
			move_left = false

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	if move_left == false:
		audio.stream = click_2
		audio.play()
		move_right = true

func _on_play_pressed() -> void:
	if !playable:
		audio.stream = blocked_click
		audio.play()
		play_clicked += 1
		if play_clicked == 4:
			hint.visible = true
	else:
		credits_mode()


func _on_fall_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		body.walk_to_screen()

func hide_all_menus():
	for m in menus:
		m.visible = false
		m.disable_collisions.call_deferred()


func _on_back_button_pressed() -> void:
	slide_back()
func slide_back():
	if move_right == false:
		audio.stream = exit_click
		audio.play()
		move_left = true
		player.opening_screen()

func credits_mode():
	dividor.one_way_collision = false
	for b in buttons:
		b.visible = false
	buttons[0].visible = true
	buttons[0].scale = Vector2(2, 2)
	buttons[0].position = Vector2(-1070.0, 641.0)
	player.object_mode = false
	credits.start_credits()
	
