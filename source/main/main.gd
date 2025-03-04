extends Node


func _ready() -> void:
	Game.game_over.connect(_on_game_over)
	AudioManager.set_game_music("Main")


func _on_game_over() -> void:
	UI.hide_control_panel()
	$Placeholder.show()
