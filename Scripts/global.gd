extends Node
enum Langs {English, Polish, German, Dutch, Empty}

signal language_change

var is_dark_mode = false

var language = Langs.English:
	set(value):
		language = value
		language_change.emit()
