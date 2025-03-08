extends CanvasLayer

@onready var unpause_bttn: SoundButton = %UnpauseBttn
@onready var master_volume_slider: HSlider = %MasterVolumeSlider
@onready var music_volume_slider: HSlider = %MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = %SfxVolumeSlider


func _ready() -> void:
	hide()
	Game.game_paused.connect(_on_game_paused)
	Game.game_unpaused.connect(_on_game_unpaused)
	unpause_bttn.pressed.connect(_on_unpause_button_pressed)
	master_volume_slider.value_changed.connect(update_audio_bus.bind("Master"))
	music_volume_slider.value_changed.connect(update_audio_bus.bind("Music"))
	sfx_volume_slider.value_changed.connect(update_audio_bus.bind("Sound Effects"))
	master_volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	music_volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sfx_volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sound Effects")))


func _on_game_paused() -> void:
	AudioServer.set_bus_effect_enabled(AudioServer.get_bus_index("Music"),0,true)
	AudioServer.set_bus_effect_enabled(AudioServer.get_bus_index("Music"),1,true)
	show()
	unpause_bttn.grab_focus()


func _on_game_unpaused() -> void:
	AudioServer.set_bus_effect_enabled(AudioServer.get_bus_index("Music"),0,false)
	AudioServer.set_bus_effect_enabled(AudioServer.get_bus_index("Music"),1,false)
	hide()


func _on_unpause_button_pressed() -> void:
	Game.game_unpaused.emit()


func update_audio_bus(new_volume : float = 0.0, bus: StringName = "Master") -> void:
	new_volume = linear_to_db(new_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), new_volume)
