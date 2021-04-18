extends RigidBody2D


export var min_speed = 700
export var max_speed = 820


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
