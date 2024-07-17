extends ColorRect


func _on_label_2_pressed():
	OS.shell_open("https://lucky-loops.itch.io/")


func _on_label_3_pressed():
	OS.shell_open("https://bdragon1727.itch.io/")


func _on_label_4_pressed():
	OS.shell_open("https://ansimuz.itch.io/")


func _on_label_5_pressed():
	OS.shell_open("https://alekssandher.itch.io/")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://title_screen.tscn")
