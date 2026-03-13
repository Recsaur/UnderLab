extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(GameControl.JanitorHealth)
	if GameControl.JanitorHealth == 4:
		$CanvasModulate/Control2/Heart5.hide()
		
	if GameControl.JanitorHealth == 3:
		$CanvasModulate/Control2/Heart5.hide()
		$CanvasModulate/Control2/Heart4.hide()
		
	if GameControl.JanitorHealth == 2:
		$CanvasModulate/Control2/Heart5.hide()
		$CanvasModulate/Control2/Heart4.hide()
		$CanvasModulate/Control2/Heart3.hide()
		
	if GameControl.JanitorHealth == 1:
		$CanvasModulate/Control2/Heart5.hide()
		$CanvasModulate/Control2/Heart4.hide()
		$CanvasModulate/Control2/Heart3.hide()
		$CanvasModulate/Control2/Heart2.hide()
		
	if GameControl.JanitorHealth <= 0:
		$CanvasModulate/Control2.hide()
