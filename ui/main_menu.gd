extends Control


func start_game():
	EzTransitions.set_easing(Tween.EASE_IN, Tween.EASE_OUT)
	EzTransitions.set_trans(Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
	EzTransitions.set_timers(1.5, 0, 1.5)
	EzTransitions.set_reverse(false, false)
	EzTransitions.set_textures("res://addons/ez_transitions/images/black_texture.png", "res://addons/ez_transitions/images/black_texture.png")
	EzTransitions.set_types(1, 1)
	EzTransitions.change_scene("res://maps/sandbox.tscn")


func _process(_delta: float):
	if $Projector2.broken:
		$AnimationPlayer.play("projector_pulsate")
	else:
		$AnimationPlayer.stop()

	if Input.is_action_just_pressed("fullscreen"):
		_on_fullscreen_pressed()


func _on_fullscreen_pressed():
	if get_window().mode == Window.MODE_FULLSCREEN:
		get_window().mode = Window.MODE_WINDOWED
		$Fullscreen.text = "Fullscreen (F10)"
	else:
		get_window().mode = Window.MODE_FULLSCREEN
		$Fullscreen.text = "Windowed (F10)"
	# Release focus so ui_accept doesn't retoggle.
	$Fullscreen.release_focus()
