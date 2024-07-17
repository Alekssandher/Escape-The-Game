extends Area2D

func _on_area_2d_area_entered(area):
	get_tree().change_scene("res://congrats.tscn")
