extends Marker2D

const OBSTACLE = preload("res://source/objects/obstacle.tscn")

@onready var spawn_timer: Timer = $SpawnTimer


func _ready() -> void:
	spawn_timer.timeout.connect(_on_timer_timout)

func _on_timer_timout() -> void:
	if self.get_child_count() < 8:
		spawn_obstacle()


func spawn_obstacle() -> void:
	var new_obstacle := OBSTACLE.instantiate()
	add_child(new_obstacle)
	new_obstacle.position.y = randf_range(-gizmo_extents,gizmo_extents)
