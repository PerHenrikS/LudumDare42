extends Area2D

func _on_Collectable_area_entered(col):
	if col.get_name() == "Player": 
		col.ammo()
		queue_free()
