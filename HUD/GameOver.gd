extends Control

func _ready():
	$Label.text = "Congradulations, your score was " + str(Global.score) 


func _on_Play_Again_pressed():
	Global.reset()
	get_tree().change_scene("res://Levels/Level1.tscn")

func _on_Quit_pressed():
	get_tree().quit()
