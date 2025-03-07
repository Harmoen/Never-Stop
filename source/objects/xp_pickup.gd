class_name XpPickup
extends Pickup

@export var xp_amount : float = 2

func on_collision() -> void:
	UI.control_panel.current_xp += 2
	
	queue_free()
