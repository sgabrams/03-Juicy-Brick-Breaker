extends StaticBody2D

var strength = 0
var points = 100

onready var Powerup_Container = null

var dying = false

func _ready():
	pass

func _physics_process(_delta):
	if dying:
		queue_free()

func set_strength(s):
	#if Powerup_Container == null:
	#	Powerup_Container = get_node_or_null("/root/Game/Powerup Container")
	if s <= 0:
	#	if Powerup_Container != null:
	#		Powerup_Container.add_powerup(position)
		die()
	strength = s 
	var x = strength *100
	$Sprite.region_rect = Rect2(x, 0, 99, 49)
	points = strength*10 + 100
	
func damage(d):
	set_strength(strength - d)
	Global.update_score(points)


func die():
	dying = true
	
	
	
