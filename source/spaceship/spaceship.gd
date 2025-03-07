class_name SpaceShip
extends Node2D

#region Variables
const MAX_HEIGHT : float = 520
const MIN_HEIGHT : float = 20
const TOUCH_DEADZONE : float = 5

@onready var hitbox: Area2D = $Hitbox
@onready var mouse_input_controller: Control = $guiInputLayer/MouseInputController
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var boost_particles: GPUParticles2D = $GPUParticles2D
@onready var pickup_area: Area2D = $PickupArea
@onready var shield_component: ShieldComponent = $ShieldComponent


# Strafing Variables
var input_direction : float = 0
var direction : float = 0
var following_mouse : bool = false
var strafe_speed : float = 500
var strafe_acceleration : float = 6
#endregion


func _ready() -> void:
	Game.ship = self
	Game.ship_reversed.connect(_on_ship_reversed)
	mouse_input_controller.gui_input.connect(_on_gui_input_event)
	pickup_area.area_entered.connect(_on_pickup_area_entered)
	boost_particles.hide()


func _process(delta: float) -> void:
	if following_mouse:
		var mouse_distance : float = get_global_mouse_position().y - self.global_position.y
		if abs(mouse_distance) > TOUCH_DEADZONE:
			input_direction = signf(mouse_distance)
	
	direction = lerp(direction, input_direction, strafe_acceleration * delta)
	
	
	self.global_position.y = clamp(
		self.global_position.y + (direction * strafe_speed * delta),
		MIN_HEIGHT,
		MAX_HEIGHT)


func _on_ship_reversed(is_reversed : bool) -> void:
	sprite_2d.flip_h = is_reversed


func _on_ship_boost_start() -> void:
	boost_particles.show()


func _on_ship_boost_end() -> void:
	boost_particles.hide()



#region Handling Input Modes
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("down") or event.is_action_pressed("up"):
		following_mouse = false
		input_direction = Input.get_axis("up","down")
	elif event.is_action_released("down") or event.is_action_released("up"):
		input_direction = Input.get_axis("up","down")


func _on_gui_input_event(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		following_mouse = true
	elif event.is_action_released("left_click"):
		following_mouse = false
		input_direction = Input.get_axis("up","down")
#endregion


func _on_pickup_area_entered(area: Area2D) -> void:
	if area is Pickup:
		area.on_collision()
	else:
		area.queue_free()
