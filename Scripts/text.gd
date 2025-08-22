extends Label
@export var english: String
@export var german: String
@export var dutch: String
@export var polish: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.language_change.connect(change_language)
	text = english

func change_language():
	#print(Global.Langs.keys()[Global.language])
	if Global.language == Global.Langs.English:
		text = english
	elif Global.language == Global.Langs.German:
		text = german
	elif Global.language == Global.Langs.Dutch:
		text = dutch
	elif Global.language == Global.Langs.Polish:
		text = polish
