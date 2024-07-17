extends Node

@onready var textBoxScene = preload("res://textBox.tscn")

var dialogLines: Array[String] = []
var currentLineIndex = 0
var talked = false

var textBox
var textBoxPosition: Vector2

var isDialogActive = false
var canAdvanceLine = false
var visible = true

func startDialog(position: Vector2, lines: Array[String]):
	if isDialogActive:
		return
	dialogLines = lines
	textBoxPosition = position
	
	if talked and currentLineIndex < 8:
		currentLineIndex = 8
	
	showTextBox()
	
	isDialogActive = true

func showTextBox():
	textBox = textBoxScene.instantiate()
	textBox.finishedDisplaying.connect(onTextBoxFinishedDisplaying)
	get_tree().root.add_child(textBox)
	textBox.global_position = textBoxPosition
	textBox.displayText(dialogLines[currentLineIndex])
	canAdvanceLine = false

func onTextBoxFinishedDisplaying():
	canAdvanceLine = true

func _unhandled_input(event):
	if (
		event.is_action_pressed("click") and
		isDialogActive and
		canAdvanceLine
	):
		textBox.queue_free()
		print(currentLineIndex)
		currentLineIndex += 1
		if currentLineIndex == 7 and currentLineIndex > 6:
			isDialogActive = false
			
			talked = true
			return
		showTextBox()
	if currentLineIndex == 10 :
		isDialogActive = false
		
		
		
		
