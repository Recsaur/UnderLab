extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

func _ready() -> void:
	HitSignal.hit.connect(TakeDmg)

func _input(event: InputEvent) -> void:
	if GameControl.CurrentWeapon == 1:
		if $Mop/Area2D/CollisionShape2D.disabled == true:
			if event.is_action_pressed("Attack"):
				print("ATTACK")
				$Mop.get_node("AnimationPlayer").play("mop_attack")
				$Mop/Area2D/CollisionShape2D.disabled = false
				await get_tree().create_timer(0.5).timeout
				$Mop/Area2D/CollisionShape2D.disabled = true


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("Left", "Right")
	
	if GameControl.JanitorHealth <= 0:
		queue_free()
	GameControl.JanitorPosX = global_position.x
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
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


func TakeDmg(Dmg,EnemyPos_x):
	var Knockback_x = 2000
	var Knockback_y = 250
	$Sprite2D.play("blood")
	GameControl.Dmged = true
	GameControl.JanitorHealth -= Dmg
	if EnemyPos_x > GameControl.JanitorPosX:
		velocity.x = -Knockback_x
	else:
		velocity.x = Knockback_x
	velocity.y = -Knockback_y
