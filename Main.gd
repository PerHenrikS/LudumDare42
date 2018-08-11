extends Node2D

var score 
var screen 

func _ready():
	screen = get_viewport_rect().size

func game_over():
	$ScoreTimer.stop()
	$HUD.show_game_over()
	$Player.end()
	$LeftWall.end()
	$RightWall.end()
	
func new_game(): 
	$ScoreTimer.start()
	score = 0
	
	$HUD.update_score(score) 
	$HUD.show_message("")
	$Player.start()
	
	$LeftWall.start(Vector2(45, screen.y / 2), 1)
	$RightWall.start(Vector2(screen.x - 45, screen.y / 2), -1)
	
func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	

func _on_Player_dead():
	game_over()

func _on_Player_ammo_display():
	$HUD.update_ammo($Player.ammo)
