extends CharacterBody2D

const ACCELERATION = 50
const DECCELERATION = 30
const SPEED = 500.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hasJump : bool
var hasDash : bool

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_floor():
		hasJump = true
		hasDash = true

	# Handle Jump.
	if Input.is_action_just_pressed("playerJump") and hasJump:
		if not is_on_floor():
			hasJump = false
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("playerMoveLeft", "playerMoveRight")
	if direction:
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECCELERATION)

	move_and_slide()

