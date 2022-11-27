extends Control

onready var PlayerScore = String(Globals.Score)
# Called when the node enters the scene tree for the first time.
func _ready():
	$YourScore/Score.set_text(PlayerScore)


func _on_Restart_pressed():
	get_tree().change_scene("res://Scenes/main.tscn")

func _on_Exit_pressed():
	get_tree().change_scene("res://Scenes/mainMenu.tscn")
