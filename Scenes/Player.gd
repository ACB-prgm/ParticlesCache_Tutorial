extends KinematicBody2D


export var lookLeft = false
const MAXSPEED = 140
const ACCELERATION = 20
const DECCELERATION = 20
var velocity = Vector2.ZERO

const PROJECTILE = preload("res://Scenes/GreenProjectile.tscn")
const MAXSTAMINA = 100.0
var skill_cost =40
var stamina_glow = 0

onready var sprite = $Sprite


var fading = false
var t = 0


func _ready():
	sprite.flip_h = lookLeft

func _physics_process(delta):
	movement(delta)
	shooting(delta)
	if fading == true:
		glow_fade(delta)


func movement(_delta):
	var input_vector = velocity
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x < 0:
			sprite.flip_h = true
		if input_vector.x >= 0:
			sprite.flip_h = false
		velocity += input_vector * ACCELERATION
		velocity = velocity.clamped(MAXSPEED)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECCELERATION)
# warning-ignore:return_value_discarded
	move_and_slide(velocity)


func shooting(_delta):
	if Input.is_action_just_pressed('ui_shoot'):
		glow_reset()
		var projectile = PROJECTILE.instance()
		get_parent().add_child(projectile)
		projectile.position = self.global_position + Vector2(0, -5)

func glow_reset():
	# Makes the sprite glow again. made to be used when shooting
	modulate = Color(1.5,1.5,1.2,1)
	fading = true
	t = 0

func glow_fade(delta):
	t += .3 * delta
	modulate = lerp(modulate, Color(1.1,1.1,1,1.1), t)
	if t >= 0.3:
		fading = false
