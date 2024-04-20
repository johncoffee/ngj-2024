extends PhysicsBody2D


@export var max_charge = 10000
@export var initial_charge = 1000
@onready var bar: = $ProgressBar


var charge: float


func _ready() -> void:
	bar.max_value = max_charge
	charge = initial_charge


func apply_damage(value: float) -> void:
	charge -= value


func apply_charge(value: float) -> void:
	charge += value


func _process(_delta: float) -> void:
	bar.value = charge
	if charge <= 0.0: push_error("WELL GG")
	if charge >= max_charge: push_error("NICE JOB")
