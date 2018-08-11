extends Area2D

#Export allows to be edited in Inspector
export (int) var speed #Player movement speed 
var screensize #Size of game window 
var projectile = preload("res://Projectile.tscn")
onready var fire_position = get_node("Position2D")

var dir = 1

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	screensize = get_viewport_rect().size
	self.position = Vector2(screensize.x/2, screensize.y/2)

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var velocity = Vector2() #Players movement vector
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("ui_select"): 
		
		if get_viewport().get_mouse_position().x < self.position.x: 
			fire_position.position.x = -45
			dir = -1 
		else: 
			fire_position.position.x = 45
			dir = 1
		
		var obj = projectile.instance()
		obj.position = Vector2(fire_position.get_global_position())
		obj.start(dir)
		
		get_parent().add_child(obj)
		
	if velocity.length() > 0: 
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else: 
		$AnimatedSprite.stop()
		
	position += velocity * delta 
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0: 
		$AnimatedSprite.animation = "Right"
		$AnimatedSprite.flip_v = false 
		$AnimatedSprite.flip_h = velocity.x < 0
