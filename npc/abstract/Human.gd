class_name Human

extends KinematicBody2D

export(Color) var skin_color := Color(255, 255, 255, 1.0)
export(Texture) var main_hand : Texture = null
export(Texture) var off_hand_front : Texture = null
export(Texture) var off_hand_back : Texture = null
export(Texture) var chest : Texture = null
export(Texture) var legs : Texture = null
export (Texture) var feet : Texture = null
export (Texture) var hands : Texture = null
export (Texture) var head : Texture = null
export (Texture) var shoulders : Texture = null
export (Texture) var back : Texture = null

onready var footsteps = $Footsteps
onready var animationTree = $AnimationTree 
onready var animationState = animationTree.get("parameters/playback")
onready var offhandW = $OffhandW
onready var offhandSN = $OffhandSN
onready var mainhandW = $MainHandW
onready var mainhandE = $MainHandE
onready var mainhandS = $MainHandS
onready var chestBackArm = $ChestBackArm
onready var chestFrontArm = $ChestFrontArm
onready var chestBody = $ChestBody
onready var hair = $Hair
onready var head_equip = $HeadEquip


var velocity : Vector2 = Vector2.ZERO
var target_position : Vector2 = Vector2.ZERO
const ACCELERATION = 70
const RUN_MAX_SPEED = 80
const MOUNTED_MAX_SPEED = RUN_MAX_SPEED * 1.5
const RUN_ROTATION = -0.258
const MOUNTED_ROTATION = RUN_ROTATION / 1.5

const FRICTION = 15
# Called when the node enters the scene tree for the first time.
func _ready():
	$Head.modulate = skin_color
	$ArmRight.modulate = skin_color
	$ArmLeft.modulate = skin_color
	$Body.modulate = skin_color
	$LegLeft.modulate = skin_color
	$LegRight.modulate = skin_color
	offhandSN.texture = off_hand_front
	offhandW.texture = off_hand_back
	mainhandW.texture = main_hand
	mainhandE.texture = main_hand
	mainhandS.texture = main_hand
	chestBackArm.texture = chest
	chestBody.texture = chest
	chestFrontArm.texture = chest
	
	if head != null:
		head_equip.texture = head
		hair.visible = false
	
	animationTree.active = true
	
func animate_move(direction : Vector2):
	animationState.travel("Run")
	animationTree.set("parameters/Idle/blend_position", direction)
	animationTree.set("parameters/Run/blend_position", direction)

func animate_idle(direction : Vector2):
	animationState.travel("Idle")
	animationTree.set("parameters/Idle/blend_position", direction)
	animationTree.set("parameters/Run/blend_position", direction)

func accelerate_to_point(point):
	var direction = global_position.direction_to(point)
	animationTree.set("parameters/Idle/blend_position", direction)
	animationTree.set("parameters/Run/blend_position", direction)
	velocity = velocity.move_toward(direction * RUN_MAX_SPEED, ACCELERATION)
	
	if global_position.distance_to(point) <= 5:
		velocity = Vector2.ZERO
		animationState.travel("Idle")
		target_position = Vector2.ZERO

func move_to_pos(position: Vector2):
	if global_position.distance_to(position) > 5:
		animationState.travel("Run")
		target_position = position

