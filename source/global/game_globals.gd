extends Node

var ship : SpaceShip
var speed : float = 0
var time_elapsed : float = 0

signal game_started
signal game_over

signal ship_reversed(reversed : bool)


func _process(delta: float) -> void:
	time_elapsed += delta
