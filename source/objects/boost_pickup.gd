class_name BoostPickup
extends Pickup

@export var boost_amount : float = 1
@export var xp_amount : float = 1


func on_collision() -> void:
	UI.control_panel.current_xp += xp_amount
	UI.control_panel.current_boost_fuel += boost_amount
	AudioManager.play_pickup()
	queue_free()
