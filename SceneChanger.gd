extends CanvasLayer

signal scene_changed()

onready var animation_player = $anim
onready var Black = $Control/Black

func change_scene(path, delay = 3):
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	get_tree().change_scene("res://areas/testroom4.tscn") 
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")

func _on_button_pressed():
	_on_doorway_enter()
	change_scene(get_tree().change_scene("res://areas/testroom4.tscn"))

func _on_doorway_enter():
	for area in $hitbox.get_overlapping_areas():
		if Input.is_action_pressed("b"):
			get_tree().change_scene("res://areas/testroom4.tscn")
			emit_signal("scene_changed")
