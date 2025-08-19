extends CharacterBody2D

# 参数
@export var speed: float = 200        # 左右移动速度
@export var jump_force: float = 400   # 跳跃力度
@export var gravity: float = 1200     # 重力大小

func _physics_process(delta: float) -> void:
	# 默认保持水平速度
	velocity.x = 0

	# A = 向左
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	# D = 向右
	if Input.is_action_pressed("move_right"):
		velocity.x = speed

	# 重力
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0  # 避免地面轻微抖动

	# W = 跳跃
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

	move_and_slide()
