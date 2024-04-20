class_name Projector
extends Area2D

@export var pan_speed := 100.0
@export var max_hp := 100.0
@export var repair_speed := 50.0

var light_on := false:
	set(value):
		light_on = value
		$LightBeam.visible = value
		$LightArea.monitoring = value
		$SpriteOpen.visible = value
		$SpriteClosed.visible = not value

var hp: float = max_hp:
	set(value):
		hp = value
		$ProgressBar.value = value

var broken := false:
	set(value):
		broken = value
		if broken:
			light_on = false
			$ProgressBar.modulate = Color.WHITE
			$SpriteClosed.modulate = Color.DIM_GRAY
		else:
			$ProgressBar.modulate = Color.GREEN_YELLOW
			$SpriteClosed.modulate = Color.WHITE


func _ready():
	# Randomly break and damage some on start.
	if randf() < 0.3:
		broken = true
		light_on = false
		hp = randf_range(0, max_hp / 2.0)
	else:
		broken = false
		# Randomly turn some on.
		light_on = randf() < 0.5
		hp = randf_range(max_hp / 2.0, max_hp)


func damage(amount: float):
	hp = max(hp - amount, 0)
	if hp == 0:
		broken = true


func repair(delta: float):
	if hp < max_hp:
		hp += delta * repair_speed
	if hp >= max_hp:
		hp = max_hp
		broken = false


func toggle_light():
	assert(not broken)
	light_on = not light_on


func pan(offset: float):
	rotation_degrees += offset * pan_speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("mirror"): return
	body.register_light(self)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if not body.is_in_group("mirror"): return
	body.unregister_light(self)
