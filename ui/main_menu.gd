extends Control


func start_game():
	EzTransitions.set_easing(Tween.EASE_IN, Tween.EASE_OUT)
	EzTransitions.set_trans(Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
	EzTransitions.set_timers(1.5, 0, 1.5)
	EzTransitions.set_reverse(false, false)
	EzTransitions.set_textures("res://addons/ez_transitions/images/black_texture.png", "res://addons/ez_transitions/images/black_texture.png")
	EzTransitions.set_types(1, 1)
	EzTransitions.change_scene("res://maps/sandbox.tscn")
