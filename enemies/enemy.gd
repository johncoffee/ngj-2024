extends CharacterBody2D

class_name Enemy

@export var health:= 100
@export var player_position: Vector2
@export var target_position: Vector2
@export var speed:= 30

func _process(delta):
	var direction = (target_position - position).normalized()
	velocity = direction*speed
	move_and_slide()
