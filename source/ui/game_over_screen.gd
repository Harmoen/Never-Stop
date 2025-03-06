extends CanvasLayer

@onready var restart_bttn: SoundButton = $RestartBttn


func _ready() -> void:
	hide()
	Game.game_over.connect(_on_game_over)
	restart_bttn.pressed.connect(_on_restart_bttn_pressed)


func _on_game_over() -> void:
	show()


func _on_restart_bttn_pressed() -> void:
	Game.game_restarted.emit()
