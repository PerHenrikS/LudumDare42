extends Area2D

#Export allows to be edited in Inspector
export (int) var speed #Player movement speed 
var screensize #Size of game window 
var projectile = preload("res://Projectile.tscn")
onready var fire_position = get_node("Position2D")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	screensize = get_viewport_rect().size

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
		#Load "thing" object when throwing
		if velocity.x != 0: 
			var obj = projectile.instance()
			obj.position = Vector2(fire_position.get_global_position())
			
			get_parent().add_child(obj)
			obj.shoot(-1)
		
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
		if velocity.x < 0: 
			fire_position.position.x = -45
		elif velocity.x > 0: 
			fire_position.position.x = 45