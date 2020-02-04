extends entity

signal scene_changed()

var state = "default"
var velocity = Vector2()


func _physics_process(delta):
	match state:
		"default":
			_state_default()
		"swing":
			_state_swing()

func _init():
	TYPE = "PLAYER"
	SPEED = 100
	

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		spritedir = "right"
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		spritedir = "left"
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
		spritedir = "down"
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		spritedir = "up"
	velocity = velocity.normalized() * SPEED    

func _state_default():
	get_input()
	damage_loop()
	movement_loop()
	_on_button_pressed()
	velocity = move_and_slide(velocity)
	if is_on_wall():
		if spritedir == "left" and test_move(transform, Vector2(-1,0)):
			anim_switch("push")
		if spritedir == "right" and test_move(transform, Vector2(1,0)):
			anim_switch("push")
		if spritedir == "up" and test_move(transform, Vector2(0,-1)):
			anim_switch("push")
		if spritedir == "down" and test_move(transform, Vector2(0,1)):
			anim_switch("push")
	elif velocity != Vector2(0,0):
		anim_switch("walk")
	else:
		anim_switch("idle")
	
	if Input.is_action_just_pressed("a"):
		use_item(preload("res://items/weapons/swords/sword.tscn"))


func _on_button_pressed():
	if Input.is_action_pressed("b"):
		_on_doorway_enter()

func _on_doorway_enter():
	for area in $hitbox.get_overlapping_areas():
			get_tree().change_scene("res://areas/testroom4.tscn")
			emit_signal("scene_changed")




func _state_swing():
	anim_switch("idle")
	movement_loop()
	damage_loop()
	movedir = dir.center

