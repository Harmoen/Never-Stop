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
@onready var accel_label: Label = %AccelLabel
@onready var boost_bttn: SoundButton = %BoostBttn
@onready var reverse_bttn: SoundButton = %ReverseBttn

## Max speed is equal to 1g, or 9.8 meters per second
var max_acceleration : float = 9.8
var acceleration : float = 0:
	set(new_accel):
		acceleration = new_accel
		accel_label.text = str(new_accel, "mph/s")
var total_speed : float = 0:
	set(new_speed):
		total_speed = new_speed
		speed_label.text = str(floor(total_speed), "mph")
var lerp_speed : float = 10
var reversed : bool = false
var boost_speed : float = 20
var boost_duration : float = 4


func _ready() -> void:
	reverse_bttn.pressed.connect(_on_reverse_bttn_pressed)


func _process(delta: float) -> void:
	acceleration = lerp(acceleration, max_acceleration * throttle.value, lerp_speed * delta)
	
	# There is no deceleration in space unless we add retrograde thrusters
	if reversed:
		total_speed -= acceleration * delta
	else:
		total_speed += acceleration * delta


func _on_reverse_bttn_pressed() -> void:
	reversed = !reversed


func _on_boost_bttn_pressed() -> void:
	pass
