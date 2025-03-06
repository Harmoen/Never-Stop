class_name Obstacle
extends Area2D

# 5000 speed seems to be the max before it's not visible anymore
@export var speed = 100
var direction : Vector2 = Vector2(-1,0)
var damage : float = 10


func _process(delta: float) -> void:
	self.position += ((minf(Game.speed,5000) + speed) * direction * delta)


func on_collision() -> void:
	queue_free()
