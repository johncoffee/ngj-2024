extends Control



func _on_go_to_arena_area_2d_body_entered(body):
	if %GoToArenaArea2D.get_overlapping_bodies().size() == 2:
		#get_tree().change_scene_to_file.bind("res://maps/sandbox.tscn").call_deferred()
		EzTransitions.set_easing(0, 1)
		EzTransitions.set_trans(0, 0)
		EzTransitions.set_timers(1.5, 0, 1.5)
		EzTransitions.set_reverse(false, false)
		EzTransitions.set_textures("res://addons/ez_transitions/images/black_texture.png", "res://addons/ez_transitions/images/black_texture.png")
		EzTransitions.set_types(1, 1)
		EzTransitions.change_scene("res://maps/sandbox.tscn")
