extends Control

func _ready() -> void:
	%PlayAgainButton.grab_focus()
	


func _on_play_again_button_pressed():
	EzTransitions.set_easing(0, 1)
	EzTransitions.set_trans(0, 0)
	EzTransitions.set_timers(1.5, 0, 1.5)
	EzTransitions.set_reverse(false, false)
	EzTransitions.set_textures("res://addons/ez_transitions/images/black_texture.png", "res://addons/ez_transitions/images/black_texture.png")
	EzTransitions.set_types(4, 1)
	EzTransitions.change_scene("res://maps/sandbox.tscn")
	pass # Replace with function body.


func _on_go_to_main_menu_pressed():
	EzTransitions.set_easing(0, 1)
	EzTransitions.set_trans(0, 0)
	EzTransitions.set_timers(1.5, 0, 1.5)
	EzTransitions.set_reverse(false, false)
	EzTransitions.set_textures("res://addons/ez_transitions/images/black_texture.png", "res://addons/ez_transitions/images/black_texture.png")
	EzTransitions.set_types(4, 1)
	EzTransitions.change_scene("res://ui/main_menu.tscn")
	pass # Replace with function body.
