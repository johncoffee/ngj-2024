extends PhysicsBody2D


signal charged
signal destroyed


@export var max_charge = 10000
@onready var bar: = $ProgressBar


@export var charge: float:
	set(value):
		value = clampf(value, 0, max_charge)
		if is_equal_approx(charge, value): return
		
		charge = value
		# So what?
		$ProgressBar.max_value = max_charge
		$ProgressBar.value = charge
		
		if is_equal_approx(charge, 0.0):
			destroyed.emit()
			set_process(false)
		elif is_equal_approx(charge, max_charge):
			set_process(false)
			charged.emit()


var charging: = false
var under_attack := false


func _ready() -> void:
	$AnimatedSprite2D.animation_finished.connect(_update_animation)


func _exit_tree() -> void:
	$AnimatedSprite2D.animation_finished.disconnect(_update_animation)


func apply_damage(value: float) -> void:
	charge -= value
	under_attack = true
	# This is a jam okay?
	get_tree().create_timer(1.0).timeout.connect(func(): under_attack = false)


func apply_charge(value: float) -> void:
	charge += value
	charging = true
	if $AnimatedSprite2D.animation == "default": $AnimatedSprite2D.play("starting")
	get_tree().create_timer(0.3).timeout.connect(func(): charging = false)


func _update_animation() -> void:
	if $AnimatedSprite2D.animation == "starting":
		$AnimatedSprite2D.play("charging")
	elif $AnimatedSprite2D.animation == "stopping":
		$AnimatedSprite2D.play("default")


func _process(_delta: float) -> void:
	if not charging and $AnimatedSprite2D.animation != "default": $AnimatedSprite2D.play("stopping")
	
	$Mask.material.set_shader_parameter("fill_amount", charge / max_charge * 0.5 + 0.5)

	if not $AudioStreamPlayer2D.playing and under_attack:
		$AudioStreamPlayer2D.play()
	elif $AudioStreamPlayer2D.playing and not under_attack:
		$AudioStreamPlayer2D.stop()
