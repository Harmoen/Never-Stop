class_name SpaceShip
extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var click_position : float = 0
var strafe_speed : float = 5000

func _process(delta: float) -> void:
	var direction = Input.get_axis("up","down")
	tween_position(global_position.y + (strafe_speed * delta * direction))


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("left_click"):
			tween_position(get_global_mouse_position().y - click_position)
	elif event.is_action_pressed("left_click"):
		click_position = get_global_mouse_position().y - self.global_position.y
	elif event.is_action_released("left_click") or event.is_action_released("down") or event.is_action_released("up"):
		skew = 0
		scale.y = 1
	elif event.is_action_pressed("shoot"):
		audio_stream_player.play()


func tween_position(new_position : float) -> void:
	# Confines ship to the screen
	new_position = clamp(new_position,0,get_viewport().size.y)
	self.scale.y = 0.8
	var distance : float = self.global_position.y - new_position
	if distance > 0:
		#print("up")
		skew = 25
	else:
		#print("down")
		skew = -25
	
	# Skip tween if distance is too small
	if abs(distance) < 1:
		self.global_position.y = new_position
	else:
		var tween := create_tween()
		tween.tween_property(self,"global_position:y",new_position,0.4).set_ease(Tween.EASE_OUT)
