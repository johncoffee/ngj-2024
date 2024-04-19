extends Node3D


func _enter_tree() -> void:
    $Path1/Player1.player_id = 1
    $Path2/Player2.player_id = 2


func _ready() -> void:
    var cam1 = $Path1/Player1/Camera3D.get_camera_rid()
    var cam2 = $Path2/Player2/Camera3D.get_camera_rid()
    var viewport1 = $HBoxContainer/Player1/SubViewport.get_viewport_rid()
    var viewport2 = $HBoxContainer/Player2/SubViewport.get_viewport_rid()
    RenderingServer.viewport_attach_camera(viewport1, cam1)
    RenderingServer.viewport_attach_camera(viewport2, cam2)
