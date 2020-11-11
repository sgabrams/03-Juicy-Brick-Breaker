extends KinematicBody2D

onready var VP = get_viewport()
onready var VP_size = get_viewport().size
export var paddle_speed = 10

func _ready():
	position.y = VP_size.y - 50


func emit_particle(pos):
	$Particles2D.global_position = pos
	$Particles2D.emmitting = true



func _physics_process(_delta):
	var target = get_viewport().get_mouse_position().x
	target = clamp(target, 0, VP_size.x)
	var d = (target - position.x)
	var s = sign(d)
	if abs(d) > paddle_speed:
		position.x += s*paddle_speed
	else:
			position.x += d


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("default") 
	 
