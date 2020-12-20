extends Area2D


const SPEED = 200
var velocity = Vector2(1,0)
var look = true
var wobble = Vector2(1,0)
var theta = 0
var amplitude = 0

onready var trail = $Particles2D
var explode = load("res://Scenes/ProjectileExplode.tscn")
var targetnode = load("res://Scenes/TrailFade.tscn")
var alive = true


func _ready():
	var coinflip = rand_range(0.0, 1.0)
	if coinflip >= 0.5:
		amplitude = 0.6
	else:
		amplitude = -0.6


func _physics_process(delta):
	if look:
		look = false
		look_at(get_global_mouse_position())
	self.global_position += velocity.rotated(rotation) * SPEED * delta
	self.global_position += wobble.rotated(rotation+90) * sin(theta)*60 * delta
	theta += amplitude
	if !alive:
		delete_missile()

func reparent_trail():
	self.remove_child(trail)
	var targott = targetnode.instance()
	get_parent().add_child(targott)
	targott.global_position = self.global_position
	targott.add_child(trail)
#	trail.set_owner(targetnode)

func delete_missile():
	set_physics_process(false)
	reparent_trail()
	var explode_ins = explode.instance()
	get_parent().add_child(explode_ins)
	explode_ins.global_position = self.global_position
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	alive = false

func _on_Area2D_area_entered(_area):
	alive = false

func _on_Area2D_body_entered(_body):
	alive = false
