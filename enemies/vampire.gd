extends Enemy

func _process(delta):
	super(delta)
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	# Keep original flip at 0.

