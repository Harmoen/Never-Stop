class_name SpaceShip
extends Node2D

#region Variables
const MAX_HEIGHT : float = 720
const MIN_HEIGHT : float = 0

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Strafing Variables
var input_direction : float = 0
var direction : float = 0
var current_strafe_speed : float = 0
var strafe_speed : float = 500
var strafe_acceleration : float = 6

# I might make the speed not controlled by the spaceship, since it's controlled by throttle
# And doesn't actually affect the position of the ship
#var current_speed : float = 1:
	#set(new_speed):
		#current_speed = new_speed
		#UI.update_speed_display(current_speed)
#endregion


func _ready() -> void:
	current_strafe_speed = strafe_speed


func _process(delta: float) -> void:
	if Input.is_action_pressed("left_click"):
		var mouse_distance : float = get_global_mouse_position().y - self.global_position.y
		if abs(mouse_distance) > 5:
			input_direction = signf(mouse_distance) 
		else:
			input_direction = 0.0
	else:
		input_direction = Input.get_axis("up","down")
	
	
	direction = lerp(direction, input_direction, strafe_acceleration * delta)
	
	
	self.global_position.y = clamp(
		self.global_position.y + (direction * current_strafe_speed * delta),
		MIN_HEIGHT,
		MAX_HEIGHT)
