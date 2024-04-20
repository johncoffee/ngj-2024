extends CharacterBody3D


func set_visibility(layers: int) -> void:
    $Sprite3D.layers = layers
