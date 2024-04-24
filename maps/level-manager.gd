extends Node

#EnemyEvents.enemy_died.emit()
# Called when the node enters the scene tree for the first time.


func _ready():
	EnemyEvents.enemy_died.connect(_handle_enemy_died)
	
	get_tree().create_timer(randf_range(10, 15)).timeout.connect(_on_VampireScream_timeout)

func _on_VampireScream_timeout():
	# This was a 2-day jam ok?
	$"../VampireScream".play()
	if is_instance_valid(get_tree()):
		get_tree().create_timer(randf_range(10, 20)).timeout.connect(_on_VampireScream_timeout)


func _handle_enemy_died():
	var ui = get_node("../UI/UIManager")
	if ui is UIManager:
		ui.increment_score()


func show_game_over() -> void:
	EzTransitions.set_easing(Tween.EASE_IN, Tween.EASE_OUT)
	EzTransitions.set_trans(Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
	EzTransitions.set_timers(1.5, 0, 1.5)
	EzTransitions.set_reverse(false, false)
	EzTransitions.set_textures("res://addons/ez_transitions/images/black_texture.png", "res://addons/ez_transitions/images/black_texture.png")
	EzTransitions.set_types(3, 4)
	EzTransitions.change_scene("res://ui/game_over.tscn")
