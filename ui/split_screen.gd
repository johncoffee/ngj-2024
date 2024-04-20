extends VBoxContainer


var registered_players: Array


func _enter_tree() -> void:
    %Player1.visible = false
    %Player2.visible = false
    %Player3.visible = false
    %Player4.visible = false
    $BottomLayer.visible = false


func register_player(player) -> void:
    registered_players.append(player)
    $BottomLayer.visible = registered_players.size() > 2
    var viewport_rid = get_node("%" + "Player%d/Viewport" % player.player_id).get_viewport_rid()
    var camera_rid = player.get_node("Camera").get_camera_rid()
    RenderingServer.viewport_attach_camera(viewport_rid, camera_rid)
    get_node("%" + "Player%d" % player.player_id).visible = true


func unregister_player(player) -> void:
    var index = registered_players.find(player)
    if index < 0: return
    
    var viewport = get_node("%" + "Player%d" % index)
    viewport.visible = false
