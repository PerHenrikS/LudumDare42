extends KinematicBody2D

var projectile_speed = 400
var velocity = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func shoot(direction): 
	move_and_slide(Vector2(direction*projectile_speed, 0))