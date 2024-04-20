extends Node

var score = 0

func _ready():
	#var scene_tree_timer := get_tree().create_timer(5)
	hide_after(7.0)
	var score_text:Label = get_node("../GameUI/Control/BoxContainer/HBoxContainer/Label")
	assert(score_text is Label)
	score_text.text = str("0 points")
		
	var tutorialCanvasLayer = get_node("../TutorialCanvasLayer")
	var tween = create_tween().set_parallel(true)
	tutorialCanvasLayer.offset.x = 960
	tutorialCanvasLayer.scale = Vector2(2, 2)
	tween.tween_property(tutorialCanvasLayer, "offset:x", 0, 0.66)
	tween.tween_property(tutorialCanvasLayer, "scale", Vector2(1,1), 0.66)

func _process(_delta):
	# maps to space/enter
	if Input.is_action_just_pressed("ui_accept"):
		add_score(1)

func hide_after(delay_time: float):
	await get_tree().create_timer(delay_time).timeout
	
	var tween = create_tween() \
		.set_parallel(true)
	var tutorialCanvasLayer = get_node("../TutorialCanvasLayer")
	tween.tween_property(tutorialCanvasLayer, "rotation", deg_to_rad(10), 0.22)
	tween.tween_property(tutorialCanvasLayer, "scale", Vector2(2,-2), 0.22)
	await get_tree().create_timer(0.221).timeout
	get_node("..").remove_child(get_node("../TutorialCanvasLayer"))
	#queue_free() # to delete self

func add_score(amount):
	var score_text:Label = get_node("../GameUI/Control/BoxContainer/HBoxContainer/Label")
	assert(score_text is Label)
	score += amount * 100
	score_text.text = str(score, " points")
	
	var control = get_node("../GameUI/Control")
	var tween = create_tween() \
		.set_parallel(true)
	control.scale = Vector2(2.2,1.6)
	control.rotation_degrees = 10
	tween.tween_property(control, "rotation_degrees", 0, 0.182)
	tween.tween_property(control, "scale", Vector2(1,1), 0.182)
	#$Tween.interpolate_property($Label.get_font("font"), "outline_color", Color(1, 1, 1, 1), Color(1, 0, 0, 1), 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	return amount

func increment_score():
	add_score(1)
