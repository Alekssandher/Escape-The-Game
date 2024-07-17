extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $Timer

const maxWidth = 300

var text = ""
var letterIndex = 0

var letterTimer = 0.03
var spaceTimer = 0.06
var punctuationTime = 0.2

signal finishedDisplaying()

func displayText(textToDisplay: String):
	text = textToDisplay
	label.text = textToDisplay
	
	await  resized
	custom_minimum_size.x = min(size.x, maxWidth)
	
	if size.x > maxWidth:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		
		custom_minimum_size.y = size.y
	
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	
	label.text = ""
	
	displayLetter()
	
func displayLetter():
	label.text += text[letterIndex]
	letterIndex += 1
	
	if letterIndex >= text.length():
		finishedDisplaying.emit()
		return
	match text[letterIndex]:
		"!", ".", ",", "?":
			timer.start(punctuationTime)
		"":
			timer.start(spaceTimer)
		_:
			timer.start(letterTimer)
	

func _on_timer_timeout():
	displayLetter()
