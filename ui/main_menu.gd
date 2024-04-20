extends Control



func _on_go_to_arena_area_2d_body_entered(body):
	if $GoToArenaPolygon/GoToArenaArea2D.get_overlapping_bodies().size() == 2:
		get_tree().change_scene_to_file.bind("res://maps/sandbox.tscn").call_deferred()
