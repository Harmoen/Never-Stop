class_name Obstacle
extends Area2D

@export var speed = 100
var direction : Vector2 = Vector2(-1,0)
var damage : float = 10


func _process(delta: float) -> void:
	self.position += ((minf(Game.speed,10000) + speed) * direction * delta)


func on_collision() -> void:
	queue_free()
