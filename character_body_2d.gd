extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

func _input(event: InputEvent) -> void:
	if $Mop/Area2D/CollisionShape2D.disabled == true:
		if event.is_action_pressed("Attack"):
			print("ATTACK")
			$Mop.get_node("AnimationPlayer").play("mop_attack")
			$Mop/Area2D/CollisionShape2D.disabled = false
			await get_tree().create_timer(0.5).timeout
			$Mop/Area2D/CollisionShape2D.disabled = true


func _physics_process(delta: float) -> void:
	GameControl.JanitorPosX = global_position.x
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		if direction == -1:
			$Sprite2D.flip_h = true
			velocity.x = direction * SPEED
		if direction == 1:
			$Sprite2D.flip_h = false
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
