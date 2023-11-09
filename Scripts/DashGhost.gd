extends Sprite2D

func _ready():
	ghosting()
				
func ghosting():
	var tween : Tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"modulate:a",0.0,0.5)

func _on_Tween_tween_all_completed():	
	queue_free()
