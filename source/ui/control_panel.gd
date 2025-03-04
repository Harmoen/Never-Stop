class_name ControlPanel
extends CanvasLayer

enum UNITS {MILES_PER_HOUR, MILES_PER_SECOND,
			KILOMETERS_PER_HOUR,KILOMETERS_PER_SECOND,
			METERS_PER_HOUR, METERS_PER_SECOND,
			MACH, KNOTS,
			ASTRONOMICAL_UNITS_PER_DAY,
			LIGHT_SPEED_FRACTION}

@export var display_units : UNITS = UNITS.KILOMETERS_PER_HOUR

@onready var shield_bar: ProgressBar = %ShieldBar
@onready var throttle: Throttle = %Throttle
@onready var speed_label: Label = %SpeedLabel
@onready var accel_label: Label = %AccelLabel
@onready var reverse_bttn: SoundButton = %ReverseBttn
@onready var boost_bttn: SoundButton = %BoostBttn
@onready var boost_timer: Timer = %BoostTimer
@onready var boost_fuel_meter: ProgressBar = %BoostFuelMeter
@onready var time_label: Label = %TimeLabel

## Max acceleration is equal to 1g, or 9.8 meters per second per second
var max_acceleration : float = 9.8
var acceleration : float = 0:
	set(new_accel):
		acceleration = max(new_accel,0)
var reversed : bool = false:
	set(new_value):
		reversed = new_value
		Game.ship_reversed.emit(reversed)
#region Boost
var max_boost_speed : float = 20
var current_boost_speed : float = 0
var boost_duration : float = 4
#endregion


func _ready() -> void:
	UI.control_panel = self
	reverse_bttn.pressed.connect(_on_reverse_bttn_pressed)
	throttle.value_changed.connect(_on_throttle_value_changed)
	boost_bttn.pressed.connect(_on_boost_bttn_pressed)
	boost_timer.timeout.connect(_on_boost_timer_timeout)


func _process(delta: float) -> void:
	# There is no deceleration in space unless the ship moves in reverse
	var added_speed = acceleration + current_boost_speed
	if reversed:
		added_speed *= -1.0
	
	Game.speed += (added_speed * delta)
	
	accel_label.text = str(floorf(added_speed * 10.0)/10.0, "m/s²")
	speed_label.text = str(floorf(Game.speed), "m/s")


func _on_reverse_bttn_pressed() -> void:
	reversed = !reversed


func _on_boost_bttn_pressed() -> void:
	boost_timer.wait_time = boost_duration
	boost_timer.start()
	var tween = create_tween()
	tween.tween_property(self,"current_boost_speed", max_boost_speed, 0.3)


func _on_boost_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self,"current_boost_speed", 0, 0.3)


func _on_throttle_value_changed(new_value : float) -> void:
	var tween = create_tween()
	tween.tween_property(self,"acceleration", max_acceleration * new_value, 0.3)


func update_shield_bar(new_value : float = 0.0) -> void:
	if abs(shield_bar.value - new_value) < 0.03:
		shield_bar.value = new_value
	else:
		var tween = create_tween()
		tween.tween_property(shield_bar,"value",new_value,0.3)
