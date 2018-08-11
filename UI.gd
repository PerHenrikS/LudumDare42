extends CanvasLayer

signal start_game 

func show_message(text): 
	$MessageLabel.text = text 
	$MessageLabel.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Tight!")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = ""
	$MessageLabel.show()
	
func update_ammo(ammo):
	$AmmoLabel.text = "Ammo: " + str(ammo)

func update_score(score): 
	$ScoreLabel.text = "Score: " + str(score)
	
func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	
func _on_MessageTimer_timeout():
	$MessageLabel.hide()