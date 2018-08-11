extends KinematicBody2D

export var pushback = 10
export var movement_speed = 10
var dir
var velocity = Vector2()

func _ready():
	$CollisionShape2D.disabled = true
	hide()
	
func end(): 
	hide()
	$CollisionShape2D.disabled = true
	position = Vector2(2000, 2000)
	
func start(start_position, direction):
	dir = direction 
	$CollisionShape2D.disabled = false
	position = start_position
	velocity = Vector2(dir * movement_speed, 0)	
	show()

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta) 

func hit():
	move_local_x(-dir * pushback)

	