class_name ControlPanel
extends CanvasLayer

#region variables
enum UNITS {MILES_PER_HOUR, MILES_PER_SECOND,
			KILOMETERS_PER_HOUR,KILOMETERS_PER_SECOND,
			METERS_PER_HOUR, METERS_PER_SECOND,
			MACH, KNOTS,
			ASTRONOMICAL_UNITS_PER_DAY,
			LIGHT_SPEED_FRACTION}

@export var display_units : UNITS = UNITS.KILOMETERS_PER_HOUR

@onready var throttle: Throttle = %Throttle
@onready var reverse_bttn: SoundButton = %ReverseBttn
@onready var pause_bttn: SoundButton = %PauseBttn
@onready var boost_bttn: SoundButton = %BoostBttn
@onready var shield_circle_meter: Sprite2D = %ShieldCircleMeter
@onready var boost_circle_meter: Sprite2D = %BoostCircleMeter
@onready var xp_bar: TextureProgressBar = %XpBar
@onready var level_label: Label = %LevelLabel
@onready var xp_label: Label = %XPLabel
@onready var time_label: Label = %TimeLabel
@onready var speed_label: Label = %SpeedLabel
@onready var accel_label: Label = %AccelLabel
@onready var danger_vignette: TextureRect = %DangerVignette

## Max acceleration is equal to 1g, or 9.8 meters per second per second
var max_acceleration : float = 9.8
var acceleration : float = 0:
	set(new_accel):
		acceleration = max(new_accel,0)
var reversed : bool = false:
	set(new_value):
		reversed = new_value
		Game.ship_reversed.emit(reversed)
var ship_level : int = 1
var xp_to_upgrade : float = 10
var current_xp : float = 0:
	set(new_value):
		current_xp = wrap(new_value,0,xp_to_upgrade)
		if new_value >= xp_to_upgrade:
			for i in floor(new_value/xp_to_upgrade):
				level_up()
		update_xp_bar(new_value / xp_to_upgrade)
		xp_label.text = str("XP: ",current_xp)
# Boost Variables
var max_boost_fuel : float = 4
var current_boost_fuel : float = 0:
	set(new_value):
		current_boost_fuel = clamp(new_value,0.0,max_boost_fuel)
		update_boost_fuel_meter(current_boost_fuel / max_boost_fuel)
		if current_boost_fuel <= 0:
			_on_boost_fuel_drained()
var max_boost_speed : float = 20
var current_boost_speed : float = 0
var boost_duration : float = 4
var is_boosting : bool = false
#endregion


func _ready() -> void:
	UI.control_panel = self
	pause_bttn.pressed.connect(_on_pause_bttn_pressed)
	reverse_bttn.pressed.connect(_on_reverse_bttn_pressed)
	throttle.value_changed.connect(_on_throttle_value_changed)
	boost_bttn.pressed.connect(_on_boost_bttn_pressed)
	Game.game_started.connect(_on_game_started)
	update_xp_bar(current_xp / xp_to_upgrade)


func _on_game_started() -> void:
	current_boost_fuel = max_boost_fuel * 0.8
	update_shield_bar(1.0)
	%IntroLabel.hide()
	%CenterPanel.show()


func _on_game_restarted() -> void:
	set_time_label()


func _process(delta: float) -> void:
	# There is no deceleration in space unless the ship moves in reverse
	var added_speed = acceleration + current_boost_speed
	if reversed:
		added_speed *= -1.0
	
	Game.speed += (added_speed * delta)
	
	if is_boosting:
		current_boost_fuel -= delta
	
	
	accel_label.text = str(Text.add_comma_to_float(floorf(added_speed * 10.0)/10.0), "m/s²")
	speed_label.text = str(Text.add_comma_to_float(floorf(Game.speed)), "m/s")
	set_time_label()
	


func _on_reverse_bttn_pressed() -> void:
	reversed = !reversed


#region Boosting
func _on_boost_bttn_pressed() -> void:
	if is_boosting:
		end_boost()
	elif current_boost_fuel > 0.3:
		start_boost()


func _on_boost_fuel_drained() -> void:
	end_boost()


func start_boost() -> void:
	Game.ship._on_ship_boost_start()
	is_boosting = true
	var tween = create_tween()
	tween.tween_property(self,"current_boost_speed", max_boost_speed, 0.3)


func end_boost() -> void:
	Game.ship._on_ship_boost_end()
	is_boosting = false
	var tween = create_tween()
	tween.tween_property(self,"current_boost_speed", 0, 0.3)


func update_boost_fuel_meter(new_value : float = 0.0) -> void:
	var new_rotation = (new_value * 1.40) - 2.72 
	if abs(boost_circle_meter.rotation - new_rotation) < 0.03:
		boost_circle_meter.rotation = new_rotation
	else:
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUAD)
		tween.tween_property(boost_circle_meter,"rotation", new_rotation, 0.3)
#endregion


func _on_throttle_value_changed(new_value : float) -> void:
	var tween = create_tween()
	tween.tween_property(self,"acceleration", max_acceleration * new_value, 0.3)


func update_shield_bar(new_value : float = 0.0) -> void:
	var new_rotation = (new_value * 1.42) - 1.85 
	if abs(shield_circle_meter.rotation - new_rotation) < 0.03:
		shield_circle_meter.rotation = new_rotation
	else:
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUAD)
		tween.tween_property(shield_circle_meter,"rotation", new_rotation, 0.4)
	
	if new_value == 0.0:
		danger_vignette.show()
	else:
		danger_vignette.hide()


func update_xp_bar(new_value : float = 0) -> void: 
	if new_value >= 1.0:
		for i in floor(new_value):
			var tween = create_tween()
			tween.tween_property(xp_bar,"value", new_value, 0.3)
			await tween.finished
			xp_bar.value = 0
		new_value = fmod(new_value,1.0)
	
	if abs(xp_bar.value - new_value) < 0.05:
		xp_bar.value = new_value
	else:
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_QUAD)
		tween.tween_property(xp_bar,"value", new_value, 0.4)


func set_time_label() -> void:
	var minutes : float = Game.time_elapsed / 60.0
	var seconds : float = fmod(Game.time_elapsed, 60.0)
	time_label.text = "%02d:%02d" % [minutes, seconds]


func level_up() -> void:
	ship_level += 1
	level_label.text = str("Level: ",ship_level)
	max_acceleration *= 1.1
	max_boost_fuel += 0.1
	max_boost_speed *= 1.1
	acceleration = throttle.value *  max_acceleration


func _on_pause_bttn_pressed() -> void:
	Game.game_paused.emit()
