class_name ShieldPickup
extends Pickup

@export var shield_amount : float = 6
@export var xp_amount : float = 1


func on_collision() -> void:
	UI.control_panel.current_xp += xp_amount
	Game.ship.shield_component.current_shield += shield_amount
	AudioManager.play_pickup()
	queue_free()
