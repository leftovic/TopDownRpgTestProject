extends Node2D

var TYPE = null
var maxamount = 1

const DAMAGE = 1



func _ready():
	TYPE = get_parent().TYPE
	$anim.connect("animation_finished", self, "destroy")
	$anim.play(str("swing", get_parent().spritedir))
	if get_parent().has_method("_state_swing"):
		get_parent().state = "swing"

func destroy(animation):
	if get_parent().has_method("_state_swing"):
		get_parent().state = "default"
	queue_free()
