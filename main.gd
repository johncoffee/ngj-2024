extends Node3D


func _ready() -> void:
    var cam1 = $Player1/Camera3D.get_camera_rid()
    var cam2 = $Player2/Camera3D.get_camera_rid()
    var viewport1 = $HBoxContainer/Player1/SubViewport.get_viewport_rid()
    var viewport2 = $HBoxContainer/Player2/SubViewport.get_viewport_rid()
    RenderingServer.viewport_attach_camera(viewport1, cam1)
    RenderingServer.viewport_attach_camera(viewport2, cam2)
