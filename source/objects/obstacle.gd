class_name Obstacle
extends Area2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

# 5000 speed seems to be the max before it's not visible anymore
@export var speed = 100
var direction : Vector2 = Vector2(-1,0)
var damage : float = 10
var raycast : RayCast2D


func _process(delta: float) -> void:
	var last_position = self.global_position
	self.global_position += ((minf(Game.speed,5000) + speed) * direction * delta)
	ray_cast_2d.target_position = last_position - self.global_position


func on_collision() -> void:
	Game.speed -= damage
	queue_free()
