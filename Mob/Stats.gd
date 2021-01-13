extends Node

export(int) var max_health = 100
onready var health = max_health setget set_health

export(int) var max_stamina = 100
onready var energy = max_stamina setget set_stamina

signal no_health

func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
		
func set_stamina(value):
	pass
