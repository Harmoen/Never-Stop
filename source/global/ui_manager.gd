extends Node

var control_panel : ControlPanel


func hide_control_panel() -> void:
	if control_panel:
		control_panel.throttle.value = 0
		control_panel.hide()


func update_shield_bar(new_value : float = 0.0) -> void:
	if control_panel:
		control_panel.update_shield_bar(clamp(new_value,0.0,1.0))
