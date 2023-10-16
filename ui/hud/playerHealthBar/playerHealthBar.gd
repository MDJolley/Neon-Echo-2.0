extends TextureProgressBar

signal healthBarReady

func _ready():
	emit_signal("healthBarReady")

func updateHealthBar(health : HealthComponent):
	max_value = health.maxHealth
	min_value = 0
	value = health.health
