extends CharacterBody2D

class_name Enemy

@export var health:= 100
@export var regen: = 10.0
@export var player_position: Vector2
@export var target_position: Vector2
@export var speed:= 30

var current_health: float

func _ready() -> void:
	current_health = health


func _process(delta):
	var direction = (target_position - position).normalized()
	velocity = direction*speed
	move_and_slide()
	
	if current_health <= 0.0: queue_free()
	current_health = min(current_health + regen * delta, health)


func apply_damage(value: float) -> void:
	if current_health - value <= 0:
		EnemyEvents.enemy_died.emit()
		
	current_health -= value
