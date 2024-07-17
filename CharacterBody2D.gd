extends CharacterBody2D

@onready var interactionArea: Area2D = $Area2D

const lines: Array[String] = [
	"Hello, my friend.",
	"Did you know that...",
	"There's a SECRET path at the bottom of that hole at the beginning of this hall?",
	"I know you can't answer; don't make that face.",
	"You should be able to answer, but...",
	"The PROGRAMMER didn't give you that kind of power.",
	"We have already talked; I don't have anything else to say for now.",
	"(The PROGRAMMER didn't add more dialogue)",
	"I fooled you. The secret passage is around here.",
	"Maybe you need to jump to get there... who knows.",
	"We're done here; no more tips for you.",
	"..."
]

#
func _unhandled_input(event):
	if event.is_action_pressed("click"):
		var overlapping_bodies = interactionArea.get_overlapping_bodies()
		if overlapping_bodies.size() > 1:
			print("Overlapping Bodies: ", overlapping_bodies.size())
			DialogManager.startDialog(global_position, lines)

#func _on_area_2d_area_entered(area):
	#
	#if Input.is_action_just_pressed("click"):
		#DialogManager.startDialog(global_position, lines)
