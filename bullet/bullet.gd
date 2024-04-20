extends Node3D

# metres pr second
@onready var velocity:Vector3 = Vector3()
var max_damage: float = 100

func _ready():
	pass # Replace with function body.


func _process(delta:float):
	($Bullet as Sprite3D).position += velocity * delta
