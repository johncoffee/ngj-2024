extends CharacterBody2D


@export var speed: float
@export var rotation_speed: float


var light_sources: Dictionary


func _process(delta: float) -> void:
	var movement = Vector2(
		Input.get_axis("mirror.move.left", "mirror.move.right"),
		Input.get_axis("mirror.move.up", "mirror.move.down")
	)
	
	position += movement * speed * delta
	
	var rotation = Input.get_axis("mirror.move.rotate.left", "mirror.move.rotate.right")
	$MirrorRoot.rotate(rotation * rotation_speed * delta)
	
	for light_source in light_sources:
		var direction: Vector2 = (position - light_source.position).normalized()
		var length: float = (position - light_source.position).length()
		var dot: = maxf(direction.dot(-$MirrorRoot.transform.y), 0)
		var beam: Line2D = light_sources[light_source]
		beam.points[1] = -direction.reflect($MirrorRoot.transform.y) / length * 30000 * dot


func register_light(light_source) -> void:
	var beam = load("res://beam.tscn").instantiate()
	add_child(beam)
	light_sources[light_source] = beam


func unregister_light(light_source) -> void:
	var beam = light_sources[light_source]
	beam.queue_free()
	light_sources.erase(light_source)
