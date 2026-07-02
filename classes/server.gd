class_name ChessServer
extends Node

var peer: SteamMultiplayerPeer

func _ready() -> void:
	pass;
	

func _on_lobby_created(connect: int, _this_lobby_id: int) -> void:
	if connect == 1:
		var peer: MultiplayerPeer = SteamMultiplayerPeer.new()
		peer.create_host(0)
		peer.server_relay = true
		multiplayer.set_multiplayer_peer(peer)
	

func _on_peer_connected(peer_id: int) -> void:
	pass
	

func _on_peer_disconnected(peer_id: int) -> void:
	pass
	
