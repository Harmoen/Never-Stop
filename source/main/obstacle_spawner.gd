extends Marker2D

const OBSTACLE = preload("res://source/objects/obstacle.tscn")
const BOOST_PICKUP = preload("res://source/objects/boost_pickup.tscn")
const SHIELD_PICKUP = preload("res://source/objects/shield_pickup.tscn")
const XP_PICKUP = preload("res://source/objects/xp_pickup.tscn")
const PICKUPS : Array = [BOOST_PICKUP, SHIELD_PICKUP, XP_PICKUP]

@onready var obstacle_spawn_timer: Timer = $ObstacleSpawnTimer
@onready var pickup_spawn_timer: Timer = $PickupSpawnTimer


func _ready() -> void:
	obstacle_spawn_timer.timeout.connect(_on_obstacle_timer_timout)
	pickup_spawn_timer.timeout.connect(_on_pickup_timer_timeout)

func _on_obstacle_timer_timout() -> void:
	if self.get_child_count() < 9:
		spawn_obstacle()
		obstacle_spawn_timer.wait_time = max(obstacle_spawn_timer.wait_time - 0.01, 1.25)
	if self.get_child_count() < 4:
		spawn_obstacle()



func _on_pickup_timer_timeout() -> void:
	if self.get_child_count() < 9:
		spawn_pickup()
		pickup_spawn_timer.wait_time = max(pickup_spawn_timer.wait_time - 0.01, 1.75)



func spawn_obstacle() -> void:
	var new_obstacle := OBSTACLE.instantiate()
	add_child(new_obstacle)
	new_obstacle.rotation = randf() * TAU
	new_obstacle.sprite_2d.frame = randi_range(0,5)
	new_obstacle.scale.x = randf_range(0.75,1.25)
	new_obstacle.scale.y = new_obstacle.scale.x
	new_obstacle.position.y = randf_range(-gizmo_extents,gizmo_extents)


func spawn_pickup() -> void:
	var new_pickup : Pickup = PICKUPS.pick_random().instantiate()
	add_child(new_pickup)
	new_pickup.rotation = randf() * TAU
	new_pickup.position.y = randf_range(-gizmo_extents,gizmo_extents)
