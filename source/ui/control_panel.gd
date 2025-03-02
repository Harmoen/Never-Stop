extends CanvasLayer

enum UNITS {MILES_PER_HOUR, MILES_PER_SECOND,
			KILOMETERS_PER_HOUR,KILOMETERS_PER_SECOND,
			METERS_PER_HOUR, METERS_PER_SECOND,
			MACH, KNOTS,
			ASTRONOMICAL_UNITS_PER_DAY,
			LIGHT_SPEED_FRACTION}

@export var display_units : UNITS = UNITS.KILOMETERS_PER_HOUR

@onready var throttle: Throttle = %Throttle
@onready var speed_label: Label = %SpeedLabel

var max_speed : float = 10
# Current speed should be the same thing as acceleration
var current_speed : float = 0
var total_speed : float = 0:
	set(new_speed):
		total_speed = new_speed
		speed_label.text = str(floor(total_speed), "mph")
var acceleration : float = 10

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	current_speed = lerp(current_speed, max_speed * throttle.value, acceleration * delta)
	
	# There is no deceleration in space unless we add retrograde thrusters
	total_speed += current_speed * delta
