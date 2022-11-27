extends Control

func _ready():
	pass 
	
func _process(delta):
	pass

func _on_StartGame_pressed():
	get_tree().change_scene("res://Scenes/main.tscn")

func _on_Exit_pressed():
	get_tree().quit()
