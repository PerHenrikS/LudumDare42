extends Node2D

var score 
var screen 

var walls
var collectable = preload("res://Collectable.tscn") 

func _ready():
	screen = get_viewport_rect().size
	walls = [$LeftWall, $RightWall]
	$AudioStreamPlayer2D.play()

func game_over():
	$ScoreTimer.stop()
	$SpawnTimer.stop()
	$HUD.show_game_over()
	$Player.end()
	$LeftWall.end()
	$RightWall.end()
	var collectables = get_node("Collects").get_children()
	for c in collectables:
		c.queue_free()
	
func new_game(): 
	var offset = 100
	var posX = $RightWall.get_child(1).get_shape().extents.x
	$LeftWall.start(Vector2((-posX/2)-offset, screen.y / 2), 1)
	$RightWall.start(Vector2(screen.x + (posX/2)+offset, screen.y / 2), -1)
	$ScoreTimer.start()
	$SpawnTimer.wait_time = 2
	$SpawnTimer.start()
	score = 0
	$Player.ammo = 5
	$HUD.update_ammo($Player.ammo)
	$HUD.update_score(score) 
	$HUD.show_message("Rumble!")
	$Player.start()

	
func _on_ScoreTimer_timeout():
	var i = randi()%2
	walls[i].velocity = walls[i].velocity*1.02
	score += 1
	$HUD.update_score(score)
	

func _on_Player_dead():
	game_over()

func _on_Player_ammo_display():
	$HUD.update_ammo($Player.ammo)


func _on_SpawnTimer_timeout():
	var obj = collectable.instance()
	var posX = $RightWall.get_child(1).get_shape().extents.x

	var randX = rand_range($LeftWall.position.x+(posX), $RightWall.position.x-(posX))
	var randY = rand_range(0, screen.y)
	
	obj.position = Vector2(
		randX, 
		randY
	)
	get_node("Collects").add_child(obj)

func _on_Player_speed_up():
	if $SpawnTimer.wait_time > .2:
		$SpawnTimer.wait_time -= 0.2


func _on_LeftWall_cam_shake():
	$Camera2D.shake()


func _on_RightWall_cam_shake():
	$Camera2D.shake()
