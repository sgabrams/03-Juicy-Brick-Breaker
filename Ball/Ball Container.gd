extends Node2D

onready var Ball = load("res://Ball/Ball.tscn")

func _ready():
	randomize()
	
func _physics_process(_delta):
		if get_child_count() == 0:
			load_ball()

func load_ball():
	var ball = Ball.instance()
	add_child(ball)
	
