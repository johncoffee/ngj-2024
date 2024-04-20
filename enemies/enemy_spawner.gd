extends Node2D
class_name EnemySpawner

# Interval between spawns in seconds
@export var interval: float
@export var enemy: PackedScene
@export var enemy_parent: Node
@export var enemy_target: Node
@export var is_spawning:= true:
	set(v):
		is_spawning = v
		if is_spawning:
			spawn()

func _ready() -> void:
	spawn()
	
func spawn() -> void:
	if is_spawning:
		var new_enemy = enemy.instantiate()
		new_enemy.position = position
		new_enemy.target_position = enemy_target.position
		enemy_parent.add_child.call_deferred(new_enemy)
		await get_tree().create_timer(interval).timeout
		spawn()
