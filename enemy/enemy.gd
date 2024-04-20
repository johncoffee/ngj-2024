extends Node3D

var hp:float = 100

@onready() var sprite:Sprite3D = $Sprite3D

func _ready():
# we expecrt a Sprite3D in the tree
	assert(sprite is Sprite3D)

func _process(_delta):
# maps to space/enter
	if Input.is_action_just_pressed("ui_accept"):
		flip()

func flip():
	var y = sprite.rotation_degrees.y
	var tween = create_tween()
	if y < 90:
		tween.tween_property($Sprite3D, "rotation_degrees:y", 90.0, 1)
	else:	
		tween.tween_property($Sprite3D, "rotation_degrees:y", 0, 1)
