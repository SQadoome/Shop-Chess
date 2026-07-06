class_name PlayerLobbyUI
extends Control

func set_player(data: PlayerData) -> void:
	$Label.text = data.username;
	$TextureRect.texture = data.pfp;
	

func set_ready(player: int, ready: bool) -> void:
	var node: ColorRect = get_node("PlayerReady" + str(player));
	if (ready):
		node.color = Color.GREEN;
	else:
		node.color = Color.RED;
	
