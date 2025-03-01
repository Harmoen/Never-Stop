extends Node

var speed_display : Label


func update_speed_display(new_speed) -> void:
	if speed_display:
		speed_display.text = str(floor(new_speed)," mph")
