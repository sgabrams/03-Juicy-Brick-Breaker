extends Control

var time = 0
onready var Indicator = load("res://HUD/Indicator.tscn")

var indicators = []

func _ready():
	Global.connect("changed" ,self, "_on_Global_changed")
	
	for i in range (Global.lives):
		var indicator = Indicator.get_instance()
		indicator.position.x = 33*i + 70
		indicator.position.y = 31
		indicator.on = true
		indicators.append(indicator)
		add_child(indicator)
	
	update_score()
	update_lives()
	update_time()
	
	

func update_score():
		$Score.text = "Score: " + str(Global.score)
		
func update_lives():
	var c = 0
	for i in indicators:
		if c < Global.lives:
			i.turn_on()
		else:
			i.turn_off()
		c += 1 
		
			
func update_time():
	$Time.text = "Time: " + str(time)
	
	
	
	
func _on_Timer_tomeout():
	time += 1
	update_time()
	
func _on_Global_changed():
	update_score()
	update_lives()

