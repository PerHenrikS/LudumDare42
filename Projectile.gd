extends KinematicBody2D

export var projectile_speed = 400
var velocity = Vector2()

func start(direction): 
	velocity = Vector2(direction * projectile_speed, 0)
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta) 
	if collision: 
		if collision.collider.has_method("hit"):
			collision.collider.hit()
			queue_free()
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()