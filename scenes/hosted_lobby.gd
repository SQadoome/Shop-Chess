extends Control


func _ready() -> void:
	Steamworks.lobby_created.connect(
		func(id: int) -> void:
			$ColorRect/Code/Label.text = "Code: " + str(id)
	);
	
