extends CharacterBody3D


func set_visibility(layers: int) -> void:
    $Sprite3D.layers = layers


# TEMPORARY
func _ready() -> void:
    set_visibility(1 << 1)
    create_tween().set_loops().tween_callback(func(): set_visibility([1 << 1, 1 << 2].pick_random())).set_delay(2)
    
