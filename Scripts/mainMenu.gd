extends Control

func _ready():
	pass 
	
func _process(_delta):
	pass

func _on_StartGame_pressed():
	$ClickSound.play()
	Globals.ScenceChangeDebug = get_tree().change_scene("res://Scenes/main.tscn")

func _on_Exit_pressed():
	$ClickSound.play()
	get_tree().quit()
	
func _on_Credits_pressed():
	$ClickSound.play()
	$CreditsWindow.popup()
