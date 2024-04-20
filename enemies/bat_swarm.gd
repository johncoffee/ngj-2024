class_name BatSwarm
extends Node2D

@export var damage := 10.0

func _process(delta):
	for area in $Area2D.get_overlapping_areas():
		if area is Projector:
			area.damage(damage * delta)
