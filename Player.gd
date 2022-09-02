extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const GRAVITY = 200.0
const WALK_SPEED = 200
const JUMP_SPEED = 200

var velocity = Vector2()
var jumping = false

func _physics_process(delta):
	velocity.y += delta * GRAVITY

	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.animation = 'walking'
		$AnimatedSprite.playing = true
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.animation = 'walking'
		$AnimatedSprite.playing = true
	else:
		velocity.x = 0
		$AnimatedSprite.playing = true
		$AnimatedSprite.animation = 'idle'

	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	move_and_slide(velocity, Vector2(0, -1))
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -JUMP_SPEED
			jumping = true
		else:
			jumping = false

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

