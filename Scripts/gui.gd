extends Control

func _ready():
	pass


func _process(_delta):
	pass
	
func set_score(score: int):
	$ScoreLabel/Points.set_text(str(score))
