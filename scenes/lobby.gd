class_name LobbyGUI
extends SceneChanger

signal player_readied(player: int)

const PLAYER_UI: PackedScene = preload("res://scenes/player_lobby_ui.tscn");
var players: Array[PlayerData] = []

func _ready() -> void:
	Steam.lobby_chat_update.connect(_update_lobby)
	_update_lobby()

func _update_lobby() -> void:
	var players: Array[PlayerData] = [];
	players.resize(2);
	
	var player_count: int = Steam.getNumLobbyMembers(Steamworks.lobby_id);
	printerr(player_count)
	for index:int in player_count:
		var p_id: int = Steam.getLobbyMemberByIndex(Steamworks.lobby_id, index);
		print(Steam.getLobbyMemberData(Steamworks.lobby_id, p_id, "username"));
		
		#var p_data: PlayerData = PlayerData.new();
		#p_data.username = Steam.getFriendPersonaName()
		
		#players[index] = p_data;
		
	

func add_player() -> void:
	pass
	
