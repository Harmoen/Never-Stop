class_name Throttle
extends VSlider

var game_started = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("throttle_up"):
		self.value = clamp(value + (1.0 / (tick_count - 1)),0,1)
	elif event.is_action_pressed("throttle_down"):
		self.value = clamp(value - (1.0 / (tick_count - 1)),0,1)


func _value_changed(_new_value: float) -> void:
	if !game_started:
		game_started = true
		Game.game_started.emit()
