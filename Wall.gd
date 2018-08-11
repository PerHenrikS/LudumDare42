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
	position = Vector2(200, 200)
	$CollisionShape2D.disabled = true
	
func start(start_position, direction):
	dir = direction 
	position = start_position
	$CollisionShape2D.disabled = false
	velocity = Vector2(dir * movement_speed, 0)	
	show()

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta) 

func hit():
	move_local_x(-dir * pushback)

	