extends Control

onready var startTween = $StartTween
onready var label = $Label
onready var button = $Button


func _physics_process(_delta):
	if ParticlesCache.loaded:
		set_physics_process(false)
		startTween.interpolate_property(label, 'rect_position', 
		label.rect_position + Vector2(0, 10), 
		label.rect_position,
		0.5, Tween.TRANS_SINE, Tween.EASE_IN)
		
		startTween.interpolate_property(button, 'rect_position', 
		button.rect_position + Vector2(0, 30), 
		button.rect_position,
		0.5, Tween.TRANS_SINE, Tween.EASE_IN)
		
		startTween.start()


func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainScene.tscn")
