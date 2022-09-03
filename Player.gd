extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const GRAVITY = 250.0
const WALK_SPEED = 200
const JUMP_SPEED = 250

var velocity = Vector2()
var jumping = false
var facing_right = true
var attack_right = false
var attack_left = false

func _physics_process(delta):
	velocity.y += delta * GRAVITY

	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
		$Hero.animation = 'walking'
		$Hero.playing = true
		facing_right = false
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
		$Hero.animation = 'walking'
		$Hero.playing = true
		facing_right = true
	else:
		velocity.x = 0
		$Hero.playing = true
		$Hero.animation = 'idle'

	if facing_right:
		$Hero.flip_h = false
	else:
		$Hero.flip_h = true
		

	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	move_and_slide(velocity, Vector2(0, -1))
	
	if !attack_right and !attack_left and Input.is_action_just_pressed("ui_attack"):
		if facing_right:
			$AttackRight.visible = true
			attack_right = true
			$AttackRight.frame = 0
			$AttackRight.play("swoosh")
		else:
			$AttackLeft.visible = true
			attack_left = true
			$AttackLeft.frame = 0
			$AttackLeft.play("swoosh")
	
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



func _on_AttackRight_animation_finished():
	attack_right = false
	$AttackRight.visible = false
	$AttackRight.stop()

func _on_AttackLeft_animation_finished():
	attack_left = false
	$AttackLeft.visible = false
	$AttackLeft.stop()
