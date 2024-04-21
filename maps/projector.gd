class_name Projector
extends Area2D

@export var pan_speed := 100.0
@export var max_hp := 100.0
@export var repair_speed := 50.0
@export var randomised: = true

@onready var bat_attractor_position = $BatAttractor.global_position
var has_bat := false
var under_attack := false


@export var light_on := false:
	set(value):
		light_on = value
		$LightBeam.visible = value
		$LightArea.monitoring = value
		$SpriteOpen.visible = value
		$SpriteClosed.visible = not value

@export var hp: float = max_hp:
	set(value):
		hp = value
		$ProgressBar.value = value

@export var broken := false:
	set(value):
		broken = value
		if broken:
			light_on = false
			$ProgressBar.modulate = Color.WHITE
			$SpriteClosed.modulate = Color.DIM_GRAY


func _ready():
	if randomised:
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

	area_entered.connect(_on_projector_area_entered)
	area_exited.connect(_on_projector_area_exited)


func _process(_delta):
	if $AudioStreamPlayer2D.playing and (hp <= 0 or not under_attack):
		$AudioStreamPlayer2D.stop()
	elif under_attack and not $AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()


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
		light_on = true


func toggle_light():
	assert(not broken)
	light_on = not light_on


func pan(offset: float):
	rotation_degrees += offset * pan_speed


func _on_projector_area_entered(_area: Area2D):
	if not has_bat:
		under_attack = false
		return
	for area in get_overlapping_areas():
		if area.get_parent() is BatSwarm:
			under_attack = true


func _on_projector_area_exited(_area: Area2D):
	if not has_bat:
		under_attack = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("mirror"): return
	body.register_light(self)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if not body.is_in_group("mirror"): return
	body.unregister_light(self)
