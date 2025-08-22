extends CharacterBody2D


const SPEED = 300.0
const CLIMB_SPEED = 200.0
const JUMP_VELOCITY = -790.0
const GRAVITY = 38

@onready var sprite = $Sprite2D
@onready var anim_player = $AnimationPlayer
@onready var leftray = $leftray
@onready var rightray = $rightray
var state_machine: CallableStateMachine = CallableStateMachine.new()

var pre_velocity := Vector2.ZERO
var prev_direction := Vector2.ZERO
var direction := Vector2.ZERO
var object_mode = true
var walking_on = false

func _ready() -> void:
	state_machine.add_states(state_run, Callable(), Callable())
	state_machine.add_states(state_idle, Callable(), Callable())
	state_machine.add_states(state_jump, state_jump_enter, Callable())
	state_machine.add_states(state_fall, state_fall_enter, Callable())
	state_machine.add_states(state_cling, state_cling_enter, Callable())
	state_machine.set_initial_state(state_idle)

func _physics_process(delta: float) -> void:
	if !object_mode:
		state_machine.update()
		velocity = pre_velocity * delta * 60
		move_and_slide()
	elif walking_on == true:
		velocity.x = 200.0
		move_and_slide()
		if position.x > 102:
			walking_on = false
			object_mode = false
			anim_player.play("idle_right")
			

func opening_screen():
	position = Vector2(-786.0, 544.0)
	anim_player.stop()
	sprite.frame = 0
	sprite.scale = Vector2(1, 1)
	object_mode = true
	walking_on = false

func walk_to_screen():
	object_mode = true
	position = Vector2(-30.0, 544.0)
	walking_on = true
	anim_player.play("run_right")

func state_run():
	horizontal_movement()
	if direction.x > 0:
		anim_player.play("run_right")
	elif direction.x < 0:
		anim_player.play("run_left")
	if !direction:
		state_machine.change_state(state_idle)
	elif Input.is_action_just_pressed("jump"):
		state_machine.change_state(state_jump)
	elif not is_on_floor():
		state_machine.change_state(state_fall)
	elif is_on_clingable_wall() and Input.is_action_pressed("grab"):
		state_machine.change_state(state_cling)

func state_idle():
	if pre_velocity:
		pre_velocity.x = move_toward(velocity.x, 0, SPEED)
		pre_velocity.y = move_toward(velocity.y, 0, CLIMB_SPEED)
	if prev_direction.x > 0:
		anim_player.play("idle_right")
	elif prev_direction.x < 0:
		anim_player.play("idle_left")
		
	if Input.get_axis("left", "right"):
		state_machine.change_state(state_run)
	elif Input.is_action_just_pressed("jump"):
		state_machine.change_state(state_jump)
	elif not is_on_floor():
		state_machine.change_state(state_fall)
	elif is_on_clingable_wall() and Input.is_action_pressed("grab"):
		state_machine.change_state(state_cling)
		

func state_jump():
	horizontal_movement()
	gravity()
	if velocity.y > 0 or Input.is_action_just_released("jump") or is_on_ceiling():
		state_machine.change_state(state_fall)
	

func state_jump_enter():
	pre_velocity.y = JUMP_VELOCITY

func state_fall():
	horizontal_movement()
	gravity()
	if is_on_floor():
		if direction.x:
			state_machine.change_state(state_run)
		else:
			state_machine.change_state(state_idle)
	elif is_on_clingable_wall() and Input.is_action_pressed("grab"):
		state_machine.change_state(state_cling)

func state_fall_enter():
	pre_velocity.y = 0
		
func state_cling():
	vertical_movement()
	if Input.is_action_just_released("grab") or not is_on_wall():
		state_machine.change_state(state_fall)
		direction.y = 0
	elif Input.is_action_just_pressed("jump"):
		state_machine.change_state(state_jump)
		direction.y = 0
func state_cling_enter():
	pre_velocity = Vector2.ZERO
	if prev_direction.x > 0:
		anim_player.play("cling_right")
	elif prev_direction.x < 0:
		anim_player.play("cling_left")

func horizontal_movement():
	if direction.x:
		prev_direction.x = direction.x
	direction.x = Input.get_axis("left", "right")
	pre_velocity.x = direction.x * SPEED

func vertical_movement():
	direction.y = Input.get_axis("up", "down")
	pre_velocity.y = direction.y * CLIMB_SPEED

func gravity():
	pre_velocity.y += GRAVITY

func is_on_clingable_wall():
	var curr_wall = leftray.get_collider() if leftray.is_colliding() else rightray.get_collider()
	if curr_wall != null:
		if is_on_wall() and not curr_wall.is_in_group("unclingable"):
			return true
	return false
