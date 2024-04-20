class_name Projector
extends Area2D

@export var pan_speed := 100
@export var light_on := false
@export var max_hp := 100
@export var repair_speed := 50

var hp := max_hp
var broken := false

func _ready():
	$LightAnchor.visible = light_on


func repair(delta: float):
	assert(broken)
	if hp < max_hp:
		hp += delta * repair_speed
	if hp >= max_hp:
		hp = max_hp
		broken = true


func toggle_light():
	assert(not broken)
	light_on = not light_on
	$LightAnchor.visible = light_on


func pan(offset: float):
	$LightAnchor.rotation_degrees += offset * pan_speed
