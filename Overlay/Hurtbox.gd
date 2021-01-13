extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

func _on_Hurtbox_area_entered(area):
	var hitEffect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(hitEffect)
	hitEffect.global_position = global_position 
