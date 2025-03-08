extends Node

var ship : SpaceShip
var speed : float = 0
var time_elapsed : float = 0

signal game_started
signal game_over
signal game_restarted
signal game_paused
signal game_unpaused

signal ship_reversed(reversed : bool)


func _ready() -> void:
	game_restarted.connect(_on_game_restarted)


func _process(delta: float) -> void:
	time_elapsed += delta


func _on_game_restarted() -> void:
	time_elapsed = 0.0
	speed = 0.0
