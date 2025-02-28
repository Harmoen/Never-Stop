extends Node

@onready var game_music: AudioStreamPlayer = $GameMusic


func set_game_music(track_title: String = "Silence") -> void:
	game_music["parameters/switch_to_clip"] = track_title
