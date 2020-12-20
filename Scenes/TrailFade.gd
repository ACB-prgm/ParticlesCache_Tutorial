extends Node2D

onready var fader = $Tween


func _ready():
	fader.interpolate_property(self, 'modulate', self.modulate, Color(1,1,1,0), 
	1, Tween.TRANS_QUINT, Tween.EASE_OUT)
	
	fader.start()	

func _on_Timer_timeout():
	queue_free()
