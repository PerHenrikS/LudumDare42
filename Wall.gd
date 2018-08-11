extends KinematicBody2D

export var pushback = 10
export var movement_speed = 10
export var direction = 0
var velocity = Vector2()

func _ready():
	velocity = Vector2(direction * movement_speed, 0)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta) 

func hit():
	move_local_x(-direction * pushback)

	