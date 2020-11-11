extends StaticBody2D

var strength = 0
var points = 100
var row = 0
onready var Powerup_Container = null

var dying = false

func _ready():
	update_color()

func _physics_process(_delta):
	if dying and $Particles2D.emitting == false:
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
	
func update_color():
	$Sprite.modulate.s = 0.5
	if row == 0:
		$Sprite.modulate = Color8(224,49,49)
	elif row == 1:
		$Sprite.	modulate  = Color8(253,126,20)
	elif row == 2:
		$Sprite.modulate  = Color8(103,65,217)
	elif row == 3:
		$Sprite.modulate  = Color8(9,146,104)
	elif row == 4:
		$Sprite.modulate = Color8(250,176,5)
	

func emit_particle(pos):
	$particles2D.global_position = pos
	$Particles2D.emmiting =  true
	




func damage(d):
	set_strength(strength - d)
	Global.update_score(points)


func die():
	$Particles2D.emitting = true
	dying = true
	
	
	
