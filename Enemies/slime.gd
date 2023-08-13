extends CharacterBody2D

## The speed of the slimes movement
@export var speed : int = 20

## When the slime is closer to the endPosition his movement speed
## will get very low, below this limit we conclude that the slime has arrived
@export var limit : float = 0.5
@export var endPoint : Marker2D

@onready var animations = $AnimationPlayer

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = endPoint.global_position

## swaps the endPosition and startPosition
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

## updates the direction in which the slime is moving
func updateVelocity():
	var moveDirection = endPosition - position
	
	## if the slime gets close to the endPosition
	## it changes directions and goes back to startPosition
	if moveDirection.length() < limit:
		changeDirection()
	
	velocity = moveDirection.normalized() * speed

## changes the animation depending on the slimes direction (velocity)
func updateAnimation():
	if velocity.length() == 0:
		animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
	
		animations.play("walk" + direction)

func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
