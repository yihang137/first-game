extends CharacterBody2D


@export var speed := 135.0          # 水平最大速度
@export var accel := 1800.0         # 加速
@export var friction := 2000.0      # 减速
@export var jump_velocity := -270.0 # 跳跃初速度（负值向上）

var gravity := 980.0

func _physics_process(delta: float) -> void:
	var dir := 0.0
	if Input.is_action_pressed("move_left"):
		dir -= 1.0
	if Input.is_action_pressed("move_right"):
		dir += 1.0

	# 水平速度（带加速/摩擦）
	if dir != 0.0:
		velocity.x = move_toward(velocity.x, dir * speed, accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, friction * delta)

	# 重力
	if not is_on_floor():
		velocity.y += gravity * delta

	# 跳跃（W）
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity

	move_and_slide()
