extends CharacterBody2D

class_name Enemy


@export var damage: float
@export var health:= 100
@export var regen: = 10.0
@export var target: Node
@export var speed:= 30

var current_health: float

func _ready() -> void:
	current_health = health


func _process(delta):
	var direction = (target.position - position).normalized()
	velocity = direction*speed
	move_and_slide()
	
	if current_health <= 0.0: queue_free()
	current_health = min(current_health + regen * delta, health)

	if (target.position - position).length_squared() < 30:
		target.apply_damage(damage)

func apply_charge(value: float) -> void:
    if current_health - value <= 0:
        EnemyEvents.enemy_died.emit()

    current_health -= value
