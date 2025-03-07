class_name XpPickup
extends Pickup

@export var xp_amount : float = 4


func on_collision() -> void:
	UI.control_panel.current_xp += xp_amount
	
	queue_free()
