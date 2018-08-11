extends Area2D

signal speedup

func _on_Collectable_area_entered(col):
	if col.get_name() == "Player": 
		col.ammo()
		col.speedup()
		queue_free()
