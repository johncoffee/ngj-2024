extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():	
	#create_tween().set_loops() \
		#.tween_callback(func(): spawn({"index": 0, "position": 
			#Vector3(lerpf(-5, 5, randf()), 0, lerp(-5, 5, randf()))})) \
		#.set_delay(2.0)
	_spawn()

func _spawn():
	var scene = load("res://ui/test-ui.tscn")
	#var scene = load(get_spawnable_scene(0))
	var instance: Node3D = scene.instantiate()
	instance.position = Vector3()
	add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
