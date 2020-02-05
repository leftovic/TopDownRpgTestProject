extends Node2D

func _ready():
	$anim.play("default")
	var _con = $anim.connect("animation_finished",self,"destroy")

func destroy(_animation):
	queue_free()


