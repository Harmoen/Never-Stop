extends Node2D

@export var hitbox : Area2D
@export var max_shield : float = 10
var current_shield : float = max_shield:
	set(new_value):
		current_shield = clamp(new_value,0,max_shield)
		if current_shield == 0:
			_on_shield_depleted()


func _ready() -> void:
	hitbox.area_entered.connect(_on_hitbox_area_entered)


func _on_hitbox_area_entered() -> void:
	pass


func _on_shield_depleted() -> void:
	pass
