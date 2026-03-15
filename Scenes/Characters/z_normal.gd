extends CharacterBody2D

const JUMP_VELOCITY = -200.0
const Dmg = 1
const SPEED = 125.0

var Health = 75
var found_janitor = false
var direction = 1


func add_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func move_enemy():
	velocity.x = SPEED * direction

func reverse_direction():
	if is_on_wall():
		direction = -direction
		$AnimatedSprite2D.flip_h = true

func _physics_process(delta: float) -> void:
	if Health <=0:
		queue_free()
	add_gravity(delta)
	move_and_slide()
	if found_janitor == false:
		move_enemy()
		reverse_direction()
	else:
		if GameControl.JanitorPosX > global_position.x:
			$AnimatedSprite2D.flip_h = false
			direction = 1
		elif GameControl.JanitorPosX < global_position.x:
			$AnimatedSprite2D.flip_h = true
			direction = -1
		velocity.x = SPEED * direction

func _on_area_2d_area_entered(area: Area2D) -> void:
	found_janitor = true
	if area.is_in_group("Mop"):
		if GameControl.CurrentWeapon == 1:
			print("is a mop")
			Takedmg(25,750,0.5)
		if GameControl.CurrentWeapon == 2:
			print("is a sh")
			Takedmg(25,550,0.25)
		if GameControl.CurrentWeapon == 3:
			print("is a bb")
			Takedmg(50,20,0.2)

func Takedmg(HealthLoss,Knockback,HitSpeed):
	if $Timer.is_stopped():
		velocity.y = JUMP_VELOCITY
		Health -= HealthLoss
		print("AHH HIT")
		print(Health)
		$Timer.start(HitSpeed)
		if GameControl.JanitorPosX > global_position.x:
			velocity.x = -Knockback
		else:
			velocity.x = Knockback
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("janitor"):
		HitSignal.hit.emit(Dmg,position.x)
		found_janitor = true
		if owner.has_method("TakeDmg"):
			owner.take_damage(Dmg,position.x)
