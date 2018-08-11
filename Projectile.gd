extends KinematicBody2D

var projectile_speed = 400

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func shoot(direction): 
#	set_linear_velocity(Vector2(direction * projectile_speed, 0))
	print("Shoot!")