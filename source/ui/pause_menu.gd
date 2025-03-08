extends CanvasLayer

@onready var unpause_bttn: SoundButton = %UnpauseBttn


func _ready() -> void:
	hide()
	Game.game_paused.connect(_on_game_paused)
	Game.game_unpaused.connect(_on_game_unpaused)
	unpause_bttn.pressed.connect(_on_unpause_button_pressed)


func _on_game_paused() -> void:
	AudioServer.set_bus_effect_enabled(AudioServer.get_bus_index("Music"),0,true)
	AudioServer.set_bus_effect_enabled(AudioServer.get_bus_index("Music"),1,true)
	show()


func _on_game_unpaused() -> void:
	AudioServer.set_bus_effect_enabled(AudioServer.get_bus_index("Music"),0,false)
	AudioServer.set_bus_effect_enabled(AudioServer.get_bus_index("Music"),1,false)
	hide()


func _on_unpause_button_pressed() -> void:
	Game.game_unpaused.emit()
