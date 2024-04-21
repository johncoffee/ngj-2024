class_name BatSwarm
extends Node2D

@export var damage := 10.0

var target_projector: Projector = null:
	set(value):
		if target_projector:
			target_projector.has_bat = false
		target_projector = value
		if target_projector:
			target_projector.has_bat = true

var spooked := false
var spooked_target_position := Vector2()


func _process(delta):
	if spooked:
		global_position = lerp(global_position, spooked_target_position, delta)
		if (global_position - spooked_target_position).abs() < Vector2(100, 100):
			get_tree().create_timer(3.0).timeout.connect(
				func(): spooked = false
			)
	else:
		if not target_projector:
			var projectors = get_tree().get_nodes_in_group("projector")
			var available = projectors.filter(func(p): return p.light_on and not p.has_bat)
			if available.size() > 0: target_projector = available.pick_random()
		if target_projector:
			global_position = lerp(global_position, target_projector.bat_attractor_position, delta)

	for area in $Area2D.get_overlapping_areas():
		if area is Projector:
			area.damage(damage * delta)
			if area.hp <= 0.0 and not spooked: spook()
	for body in $Area2D.get_overlapping_bodies():
		if body is ProjectorPlayer and not spooked:
			spook()


func spook() -> void:
	spooked = true
	var target_x := randf_range(2000, 3000) if randf() > 0.5 else randf_range(-1000, 0)
	var target_y := randf_range(1000, 2000) if randf() > 0.5 else randf_range(-1000, 0)
	spooked_target_position = Vector2(target_x, target_y)
	target_projector = null
