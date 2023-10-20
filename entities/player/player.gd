extends CharacterBody2D
class_name Player

@onready var movement_controller = $movementController


func _physics_process(delta):
	velocity = movement_controller.velocity
	move_and_slide()

func die():
	queue_free()
	
	
	
	
	
	
	
	
	
