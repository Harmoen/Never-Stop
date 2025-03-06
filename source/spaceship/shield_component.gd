extends Node2D

@export var hitbox : Area2D
@export var max_shield : float = 50
var current_shield : float = 50:
	set(new_value):
		current_shield = clamp(new_value,0,max_shield)
		UI.update_shield_bar(current_shield/max_shield)
		if current_shield == 0:
			_on_shield_depleted()


func _ready() -> void:
	hitbox.area_entered.connect(_on_hitbox_area_entered)


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Obstacle:
		area.on_collision()
		take_damage(area.damage)
	else:
		area.queue_free()


func take_damage(damage_amount : float) -> void:
	if self.current_shield <= 0 and damage_amount > 0:
		death()
	else:
		self.current_shield -= damage_amount


func _on_shield_depleted() -> void:
	pass


func death() -> void:
	Game.game_over.emit()
