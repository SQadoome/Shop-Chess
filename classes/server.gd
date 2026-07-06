class_name ChessServer
extends Node

signal player_joined_lobby(data: PlayerData);

var peer: SteamMultiplayerPeer

func _ready() -> void:
	peer = SteamMultiplayerPeer.new();
	peer.create_host();
	

@rpc("reliable")
func _ask_to_join() -> void:
	Steam
	
