extends TextureProgress

func _physics_process(delta):
	value = get_tree().get_root().get_node("Node2D/YSort/Player").get("stamina")
