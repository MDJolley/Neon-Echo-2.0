extends Node2D

class_name HealthComponent

@export var maxHealth : int

var health : int
signal healthDepleted
signal healthChanged

func _ready():
	modifyHealth(maxHealth)

func modifyHealth(amount : int):
	health = clamp(health + amount, 0, maxHealth)
	if health == 0:
		emit_signal("healthDepleted")
	emit_signal("healthChanged", self)

func processDamage(hitbox : Node):
	var damageComponent : Damage = hitbox.get_node("damageComponent")
	if not damageComponent:
		print("What hit me?")
	else:
		modifyHealth(-damageComponent.quantity)
	
