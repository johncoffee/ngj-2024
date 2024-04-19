extends Node3D

var hp = 0

@onready() var sprite:Sprite3D = $Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(sprite is Sprite3D)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		flip()

func flip():
	var y = sprite.rotation_degrees.y
	var tween = create_tween()
	print(y)
	if y < 90:
		tween.tween_property($Sprite3D, "rotation_degrees:y", 90.0, 1)
	else:	
		tween.tween_property($Sprite3D, "rotation_degrees:y", 0, 1)
