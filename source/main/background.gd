extends CanvasLayer

const TOP_SHIP_SPEED : float = 100000

@onready var background_material : ShaderMaterial = $Background.material
@onready var update_timer: Timer = $UpdateTimer

func _ready() -> void:
	update_timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var speed_1 : float = clamp(Game.speed / TOP_SHIP_SPEED, 0.04, 1.0)
	var speed_2 : float = clamp((Game.speed / 8) / TOP_SHIP_SPEED, 0.05, 1.0)
	background_material.set_shader_parameter("base_scroll_speed", speed_1)
	background_material.set_shader_parameter("additional_scroll_speed", speed_2)
