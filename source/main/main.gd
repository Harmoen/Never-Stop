extends Node


func _ready() -> void:
	Game.game_over.connect(_on_game_over)
	Game.game_paused.connect(_on_game_paused)
	Game.game_unpaused.connect(_on_game_unpaused)
	
	AudioManager.set_game_music("Main")


func _on_game_over() -> void:
	$Placeholder.show()


func _on_game_paused() -> void:
	get_tree().paused = true


func _on_game_unpaused() -> void:
	get_tree().paused = false
