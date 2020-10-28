extends Control

var time = 0
onready var Indicator = load("res://HUD/Indicator.tscn")

var indicators = []

func _ready():
	var _new_signal = Global.connect("changed" ,self, "_on_Global_changed")
	
	for i in range (Global.lives):
		var indicator = Indicator.instance()
		indicator.position.x = 15*i + 60
		indicator.position.y = 17
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
			i.show()
		else:
			i.hide()
		c += 1 
		
			
func update_time():
	$Time.text = "Time: " + str(time)
	
	
	
	
func _on_Global_changed():
	update_score()
	update_lives()



func _on_Timer_timeout():
	time += 1
	update_time()
