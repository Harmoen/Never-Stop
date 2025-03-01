class_name SoundButton
extends Button


func _ready() -> void:
	mouse_entered.connect(_on_hover)
	pressed.connect(_on_pressed)


func _on_hover() -> void:
	AudioManager.play_ui_hover()


func _on_pressed() -> void:
	AudioManager.play_ui_click()
