class_name Networks
extends Node2D

const PORT: int = 7474;
var peer: ENetMultiplayerPeer
var IP_ADDRESS: String

var Players: Dictionary = {
	"Player1": {
		"Team": 0,
		"JoinOrder": 1,
		"Username": "",
		"Coins": 5
	},
	"Player2": {
		"Team": 0,
		"JoinOrder": 1,
		"Username": "",
		"Coins": 5
	}
}

var username: String = "";

signal player_joined(username: String, player_id: int, peer_id: int)
signal lobby_created

func _ready() -> void:
	pass
	

func create_lobby() -> void:
	pass
	

func join_lobby() -> void:
	pass
	

func _on_lobby_joined(this_lobby_id: int, _permissions: int, _locked: bool, response: int) -> void:
	if response == Steam.CHAT_ROOM_ENTER_RESPONSE_SUCCESS:
		var id = Steam.getLobbyOwner(this_lobby_id);
		
		if id != Steam.getSteamID():
			var peer: MultiplayerPeer = SteamMultiplayerPeer.new()
			var server_steam_id: int = Steam.getLobbyOwner(this_lobby_id)
			peer.create_client(server_steam_id, 0)
			peer.server_relay = true
			multiplayer.set_multiplayer_peer(peer)
		
	
