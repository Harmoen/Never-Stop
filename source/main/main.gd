extends Node


func _ready() -> void:
	Game.game_over.connect(_on_game_over)
	Game.game_paused.connect(_on_game_paused)
	Game.game_unpaused.connect(_on_game_unpaused)
	Game.game_restarted.connect(_on_game_restarted)
	
	AudioManager.set_game_music("Main")


func _on_game_over() -> void:
	get_tree().paused = true


func _on_game_paused() -> void:
	get_tree().paused = true


func _on_game_unpaused() -> void:
	get_tree().paused = false


func _on_game_restarted() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
