class_name ProjectorPlayer
extends CharacterBody2D

@export var speed := 300

var close_projector: Projector = null


func _ready():
	$ProjectorDetector.area_entered.connect(_on_projector_detector_area_entered)
	$ProjectorDetector.area_exited.connect(_on_projector_detector_area_exited)


func _process(delta):
	var direction := Input.get_vector(
			"projector.move.left", "projector.move.right",
			"projector.move.up", "projector.move.down",
	)
	velocity = direction * speed
	move_and_slide()

	if close_projector:
		var pan_direction := Input.get_axis("projector.pan.left", "projector.pan.right")
		close_projector.pan(pan_direction * delta)

		if Input.is_action_pressed("projector.repair"):
			close_projector.repair(delta)
			%GPUParticles2D.emitting = true
		elif Input.is_action_just_pressed("projector.toggle"):
			if not close_projector.broken:
				close_projector.toggle_light()
		else:
			%GPUParticles2D.emitting = false


func _on_projector_detector_area_entered(area: Area2D):
	if area is Projector:
		close_projector = area


func _on_projector_detector_area_exited(area: Area2D):
	if area is Projector:
		close_projector = null
