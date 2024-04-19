extends Node3D


@export var local_player_count: int = 1


func _ready() -> void:
    get_viewport().disable_3d = true
    
    for i in range(local_player_count):
        var player_scene = load("res://player.tscn")
        var player: PathFollow3D = player_scene.instantiate()
        player.player_id = i + 1
        $SplitScreen.register_player(player)
        
        var path_node: Path3D = get_node("Path%d" % (i + 1))
        path_node.add_child(player)
        player.progress_ratio = 0.5
