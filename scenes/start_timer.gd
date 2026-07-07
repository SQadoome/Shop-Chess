class_name StartTimer
extends Control

signal finished

func start(iteration: int = 4) -> void:
	$Label.text = str(iteration);
	
	if (iteration <= 0):
		finished.emit();
		return;
	
	await get_tree().create_timer(1.0).timeout;
	start(iteration - 1);
	
