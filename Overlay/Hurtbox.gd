extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

func _on_Hurtbox_area_entered(area):
	var hitEffect = HitEffect.instance()
	get_parent().add_child(hitEffect)
	hitEffect.global_position = global_position 
