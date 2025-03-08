extends Node

@onready var game_music: AudioStreamPlayer = $GameMusic
@onready var sfx_ui_click: AudioStreamPlayer = $sfxUIClick
@onready var sfx_ui_hover: AudioStreamPlayer = $sfxUIHover
@onready var sfx_pickup: AudioStreamPlayer = $sfxPickup


func set_game_music(track_title: String = "Silence") -> void:
	game_music["parameters/switch_to_clip"] = track_title


func play_ui_click() -> void:
	sfx_ui_hover.play()


func play_ui_hover() -> void:
	sfx_ui_click.play()


func play_pickup() -> void:
	sfx_pickup.play()
