extends MultiplayerSpawner


func _ready() -> void:
    spawn_function = _spawn
    
    create_tween().set_loops() \
        .tween_callback(func(): spawn({"index": 0, "position": Vector3(lerpf(-5, 5, randf()), 0, lerp(-5, 5, randf()))})) \
        .set_delay(3.0)


func _spawn(params) -> Node:
    var scene = load(get_spawnable_scene(params.index))
    var instance: Node3D = scene.instantiate()
    instance.position = params.position
    instance.set_visibility(1 << (1 + range(get_parent().local_player_count).pick_random()))
    return instance
