extends RigidBody2D

onready var VP = get_viewport_rect().size
var speed = 400
var min_speed = 100.0
var max_speed = 400.0
var collided = false
export var speedup = 1.05

var released = false 

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)
	if not released:
		mode = RigidBody2D.MODE_KINEMATIC
	$Sprite.modulate.s = 0.5


func update_color():
	$Color.color = Color8(34,184,207)
	



func release_ball():
	released = true
	mode = RigidBody2D.MODE_RIGID
	var impulse = Vector2.RIGHT*speed
	impulse = impulse.rotated(randf()*-PI)
	print(impulse)
	apply_central_impulse(impulse)


func _physics_process(_delta):
	var paddle = get_node_or_null("/root/Game/Paddle Container/Paddle")
	if not released and paddle != null:
		position = paddle.position
		position.y -= 30
	else:
		if position.y > VP.y + 30:
			die()
		
		var bodies = get_colliding_bodies()
		for body in bodies:
			collided = true
			if body.get_parent().name== "Paddle Container":
				$Sprite.modulate.h+=0.1
				body.get_node("Particles2D").emitting = true
				get_node("/root/Game/Paddle_Sound").playing = true
			if body. is_in_group("brick"):
				body.damage(1)
				get_node("/root/Game/Brick_Sound").playing = true
			get_node("/root/Game/Camera").add_trauma(0.2)
	if Input.is_action_just_pressed("release") and not released:
		release_ball()

func _integrate_forces(state):
	if collided:
		state.linear_velocity *= speedup
		collided =  false
	if abs(state.linear_velocity.x) < min_speed:
		state.linear_velocity.x = sign(state.linear_velocity.x) * min_speed
	if abs(state.linear_velocity.x) < max_speed:
		state.linear_velocity.x = sign(state.linear_velocity.x) * max_speed
	if abs(state.linear_velocity.y) < min_speed:
		state.linear_velocity.y = sign(state.linear_velocity.y) * min_speed
	if abs(state.linear_velocity.y) < max_speed:
		state.linear_velocity.y = sign(state.linear_velocity.y) * max_speed


func die():
	Global.update_lives(-1)
	queue_free()
	


