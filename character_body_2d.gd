extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	HitSignal.hit.connect(TakeDmg)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("1"):
		print($Sprite2D.sprite_frames.get_animation_names())
		if GameControl.Dmged:
			$Sprite2D.play("mopblod")
		else:
			$Sprite2D.play("mop")
			
	if event.is_action_pressed("2") and GameControl.Shiv:
		if GameControl.Dmged:
			$Sprite2D.play("shivblood")
		else:
			$Sprite2D.play("shiv")
			
	if event.is_action_pressed("3") and GameControl.BB:
		if GameControl.Dmged:
			$Sprite2D.play("bbblood")
		else:
			$Sprite2D.play("bb")
			
	if GameControl.CurrentWeapon > 0:
		if $Mop/Area2D/CollisionShape2D.disabled == true:
			if event.is_action_pressed("Attack"):
				WeaponAttack()


func WeaponAttack():
	print("ATTACK")
	var cooldown = 5
	if GameControl.CurrentWeapon == 1:
		cooldown = 0.5
		if GameControl.Dmged:
			$Sprite2D.play("mopblodattack")
		else:
			$Sprite2D.play("mopattack")
	if GameControl.CurrentWeapon == 2:
		cooldown = 0.25
		if GameControl.Dmged:
			$Sprite2D.play("shivbloodattack")
		else:
			$Sprite2D.play("shivattack")
		
	if GameControl.CurrentWeapon == 3:
		cooldown = 0.2
		if GameControl.Dmged:
			$Sprite2D.play("bbbloodattack")
		else:
			$Sprite2D.play("bbattack")
	$Mop/Area2D/CollisionShape2D.disabled = false
	$Mop.get_node("Sprite2D").modulate = Color()
	await get_tree().create_timer(cooldown).timeout
	$Mop.get_node("Sprite2D").modulate = Color(0.0, 0.0, 0.0, 0.294)
	$Mop/Area2D/CollisionShape2D.disabled = true
	
	#return to idle state
	if GameControl.CurrentWeapon == 1:
		if GameControl.Dmged:
			$Sprite2D.play("mopblod")
		else:
			$Sprite2D.play("mop")
	if GameControl.CurrentWeapon == 2:
		if GameControl.Dmged:
			$Sprite2D.play("shivblood")
		else:
			$Sprite2D.play("shiv")
	if GameControl.CurrentWeapon == 3:
		if GameControl.Dmged:
			$Sprite2D.play("bbblood")
		else:
			$Sprite2D.play("bb")

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
