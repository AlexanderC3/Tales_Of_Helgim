extends Node

var tween : Tween = get_tree().create_tween()

func _ready():
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_Ease(Tween.EASE_OUT)
	tween.tween_property(self,"modulate:a",0.0,0.5)
