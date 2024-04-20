class_name Projector
extends Area2D

@export var pan_speed := 100.0
@export var max_hp := 100.0
@export var repair_speed := 50.0

var light_on := false:
	set(value):
		light_on = value
		$LightAnchor.visible = value
		$LightArea.monitoring = value

var hp: float = max_hp:
	set(value):
		hp = value
		$ProgressBar.value = value

var broken := false:
	set(value):
		broken = value
		if broken:
			$Sprite2D.modulate = Color.DIM_GRAY
		else:
			$Sprite2D.modulate = Color.WHITE


func _ready():
	# Randomly break some on start.
	if randf() < 0.3:
		broken = true
		hp = randf_range(0, max_hp / 2.0)
		# Randomly turn some on.
		light_on = randf() < 0.5
	else:
		broken = false
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
	$LightAnchor.rotation_degrees += offset * pan_speed


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("mirror"): return
	body.register_light(self)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if not body.is_in_group("mirror"): return
	body.unregister_light(self)
