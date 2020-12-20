extends Particles2D


func _ready():
	self.set_one_shot(true)

func _on_Timer_timeout():
	queue_free()


