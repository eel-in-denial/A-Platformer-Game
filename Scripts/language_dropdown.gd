extends StaticBody2D

@onready var menu = $Node2D
@onready var menu_coll = $MenuCollision
@onready var collision = $CollisionShape2D
@onready var english_box = $Node2D/menu/enghover
@onready var polish_box = $Node2D/menu/polhover2
@onready var german_box = $Node2D/menu/gerhover3
@onready var dutch_box = $Node2D/menu/duthover4
@onready var language_text = $Language
@onready var audio = $AudioStreamPlayer
var click = preload("res://Assets/SoupTonic UI1 SFX Pack 1 - ogg/SFX_UI_MenuSelections.ogg")
var assign = preload("res://Assets/SoupTonic UI1 SFX Pack 1 - ogg/SFX_UI_Confirm.ogg")
var close = preload("res://Assets/SoupTonic UI1 SFX Pack 1 - ogg/SFX_UI_Cancel.ogg")

var language_hover = Global.Langs.English

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu.visible = false
	menu_coll.disabled = true

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			open_menu()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and menu.visible == true and language_hover != Global.Langs.Empty:
			Global.language = language_hover
			language_text.text = Global.Langs.keys()[language_hover]
			close_menu()
			audio.stream = assign
			audio.play()
		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed and menu.visible == true:
			close_menu()
		

func open_menu():
	menu.visible = true
	menu_coll.disabled = false
	audio.stream = click
	audio.play()

func close_menu():
	menu.visible = false
	menu_coll.disabled = true
	audio.stream = close
	audio.play()

func _on_eng_area_mouse_entered() -> void:
	english_box.visible = true
	language_hover = Global.Langs.English


func _on_eng_area_mouse_exited() -> void:
	english_box.visible = false

func _on_pol_area_mouse_entered() -> void:
	polish_box.visible = true
	language_hover = Global.Langs.Polish


func _on_pol_area_mouse_exited() -> void:
	polish_box.visible = false

func _on_ger_area_mouse_entered() -> void:
	german_box.visible = true
	language_hover = Global.Langs.German


func _on_ger_area_mouse_exited() -> void:
	german_box.visible = false

func _on_dut_area_mouse_entered() -> void:
	dutch_box.visible = true
	language_hover = Global.Langs.Dutch


func _on_dut_area_mouse_exited() -> void:
	dutch_box.visible = false


func _on_mouse_exited() -> void:
	language_hover = Global.Langs.Empty

func disable_collisions():
	menu_coll.disabled = true
	collision.disabled = true
func enable_collisions():
	collision.disabled = false
