extends Node2D
class_name MovementController

#Physics constants
const ACCELERATION = 50
const DECCELERATION = 20
const SPEED = 500.0
const JUMP_VELOCITY = -800.0
const DASH_VELOCITY = 1500
const MAX_VELOCITY = 1500

#Onready and preloads
@onready var player = $".."
@onready var particleEmitter = $ParticleEmitter

#Relative variables
var velocity : Vector2
var hasJump : bool
var hasDash : bool
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dashing : bool
var bufferJump : bool

func _physics_process(delta):
	velocity = player.velocity
		# Add the gravity.
	if not player.is_on_floor():
		velocity.y += gravity * delta
	
	#Handle Resource Recovery
	if player.is_on_floor():
		hasJump = true
		hasDash = true
	
	# Handle Dash.
	if dashing:
		if Input.is_action_just_pressed("playerJump") and hasJump:
			bufferJump = true
		return
	
	if Input.is_action_just_pressed("playerDash") and hasDash and not dashing:
		dashing = true
		particleEmitter.emitDash()
		velocity = dash() * DASH_VELOCITY
		await get_tree().create_timer(.15).timeout
		dashing = false
		velocity.x = clamp(velocity.x, -SPEED, SPEED)
		velocity.y = clamp(velocity.y, -SPEED, SPEED)
		if bufferJump:
			bufferJump = false
			jump()

	# Handle Jump.
	if Input.is_action_just_pressed("playerJump") and hasJump:
		jump()
	
	# Handle Movement.
	var direction = Input.get_axis("playerMoveLeft", "playerMoveRight")
	if direction:
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECCELERATION)

func jump():
	if not player.is_on_floor():
		hasJump = false
	velocity.y = JUMP_VELOCITY

func dash() -> Vector2:
	var vertDirection = Input.get_axis("playerMoveUp", "playerMoveDown")
	var horDirection = Input.get_axis("playerMoveLeft", "playerMoveRight")
	var dashVelocity = Vector2(horDirection, vertDirection).normalized()
	return dashVelocity
