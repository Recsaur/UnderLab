extends Node2D
var PlayerHere = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and PlayerHere:
		print("GOT")
		GameControl.BB = true
		
		queue_free()
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	PlayerHere = true
	$".".modulate = Color(1.825, 1.825, 1.825, 1.0)
	$Panel.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	$Panel.hide()
	$".".modulate = Color(1.0, 1.0, 1.0, 1.0)
	PlayerHere = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_area_2d_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
