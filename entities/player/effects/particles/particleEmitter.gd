extends GPUParticles2D

@onready var dashParticles = preload("res://entities/player/effects/particles/dashParticles.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func emitDash ():
	process_material = dashParticles
	emitting = true
	await get_tree().create_timer(.25).timeout
	emitting = false
