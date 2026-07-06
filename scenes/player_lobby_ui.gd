class_name PlayerLobbyUI
extends Control

func set_player(data: PlayerData) -> void:
	$Label.text = data.username;
	$TextureRect.texture = data.pfp;
	set_ready(data.ready_value);
	

func set_ready(ready: bool) -> void:
	var node: ColorRect = get_node("PlayerReady");
	if (ready):
		node.color = Color.GREEN;
	else:
		node.color = Color.RED;
	
