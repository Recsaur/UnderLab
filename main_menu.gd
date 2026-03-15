extends Node2D
const maingame = preload("res://Scenes/Maps/map.tscn")
var  button_type = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	button_type = "start"
	$ColorRect.show()
	$ColorRect/FadeTimer.start()
	$ColorRect/AnimationPlayer.play("FadeOut")
	pass # Replace with function body.


func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_packed(maingame)
	pass # Replace with function body.


func _on_close_pressed() -> void:
	$CanvasLayer.hide()


func _on_credits_pressed() -> void:
	$CanvasLayer.show()
