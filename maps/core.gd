extends PhysicsBody2D


@export var max_charge = 10000
@export var initial_charge = 4000
@onready var bar: = $ProgressBar


var charge: float
var under_attack := false


func _ready() -> void:
	bar.max_value = max_charge
	charge = initial_charge


func apply_damage(value: float) -> void:
	charge -= value
	under_attack = true
	# This is a jam okay?
	get_tree().create_timer(1.0).timeout.connect(func(): under_attack = false)


func apply_charge(value: float) -> void:
	charge += value


func _process(_delta: float) -> void:
	bar.value = charge
	$Mask.material.set_shader_parameter("fill_amount", charge / max_charge * 0.5 + 0.5)

	if not $AudioStreamPlayer2D.playing and under_attack:
		$AudioStreamPlayer2D.play()
	elif $AudioStreamPlayer2D.playing and not under_attack:
		$AudioStreamPlayer2D.stop()

	if charge <= 0.0:
		process_mode = Node.PROCESS_MODE_DISABLED
		EzTransitions.set_easing(0, 1)
		EzTransitions.set_trans(0, 0)
		EzTransitions.set_timers(1.5, 0, 1.5)
		EzTransitions.set_reverse(false, false)
		EzTransitions.set_textures("res://addons/ez_transitions/images/black_texture.png", "res://addons/ez_transitions/images/black_texture.png")
		EzTransitions.set_types(3, 4)
		EzTransitions.change_scene("res://ui/game_over.tscn")
	if charge >= max_charge: push_error("NICE JOB")
