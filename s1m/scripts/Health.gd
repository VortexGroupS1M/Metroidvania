extends Node
export(int) var maxHealth : int = 200

var health : int

func _ready() -> void:
	health = maxHealth

func damage(amaunt : int) -> void:
	health -= amaunt
	if( health <= 0):
		die()
		$"..".queue_free()




func die() -> void:
	pass