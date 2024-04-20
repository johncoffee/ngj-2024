extends MultiplayerSpawner
class_name EnemySpawner

# Interval between spawns in seconds
@export var interval: float
@export var enemy_target: Node
@export var is_spawning:= true


func _ready() -> void:
	spawn_function = _spawn
	create_tween().bind_node(self).set_loops() \
		.tween_callback(func(): spawn({"scene_index": 0, "spawn_point_index": range(get_child_count()).pick_random()})) \
		.set_delay(interval)

	
func _spawn(params) -> Node:
	var new_enemy = load(get_spawnable_scene(params.scene_index)).instantiate()
	new_enemy.position = get_child(params.spawn_point_index).position
	new_enemy.target = enemy_target
	return new_enemy
