extends Label
var credits_text = """Credits
Developer - Daniel Lee

Assets (linked in itch)
Player art - Kevin's Mom's House
Keyboard art - Dream Mix
Font - datagoblin
Sound effects - SoupTonic"""
var counter = 0
@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = ""


func start_credits():
	timer.start()


func _on_timer_timeout() -> void:
	counter += 1
	text = credits_text.substr(0, counter)
