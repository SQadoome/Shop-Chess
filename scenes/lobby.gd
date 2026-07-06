class_name LobbyGUI
extends SceneChanger

signal player_readied(player: int)

const PLAYER_UI: PackedScene = preload("res://scenes/player_lobby_ui.tscn");
var players: Array[PlayerData] = []

func _ready() -> void:
	Steam.lobby_chat_update.connect(_update_lobby);
	Steam.lobby_data_update.connect(
		func(success: int, lobby_id: int, member_id: int) -> void:
			_update_lobby();
	);
	_update_lobby();
	
	$Button.pressed.connect(_update_ready);

func _update_ready() -> void:
	var old_value: String = Steam.getLobbyMemberData(
		Steamworks.lobby_id, Steam.getSteamID(), "ready"
	)
	var new_value: String = "";
	if (old_value == "true"):
		new_value = "false";
		$Button.text = "READY";
	else:
		new_value = "true";
		$Button.text = "UNREADY";
	
	Steam.setLobbyMemberData(
		Steamworks.lobby_id, "ready", new_value
	);
	

func _update_lobby_data() -> void:
	players.resize(2);
	
	var player_count: int = Steam.getNumLobbyMembers(Steamworks.lobby_id);
	for index:int in player_count:
		var p_id: int = Steam.getLobbyMemberByIndex(Steamworks.lobby_id, index);
		var username: String = Steam.getLobbyMemberData(
			Steamworks.lobby_id, p_id, "username");
		
		var ready_str: String = Steam.getLobbyMemberData(
			Steamworks.lobby_id, p_id, "ready");
		
		var p_data: PlayerData = PlayerData.new();
		p_data.username = username;
		p_data.set_ready(ready_str);
		p_data.position_in_lobby = Steam.getNumLobbyMembers(Steamworks.lobby_id);
		players[index] = p_data;
		
	

func _set_players() -> void:
	for child:Control in $Players.get_children():
		child.queue_free();
		
	
	for index:int in players.size():
		var data: PlayerData = players[index];
		
		var player_ui: PlayerLobbyUI = PLAYER_UI.instantiate();
		add_child(player_ui);
		player_ui.position.y += index*(64 + 16);
		player_ui.set_player(data);
		
	

func _update_lobby() -> void:
	_update_lobby_data();
	_set_players();
	

#109775242146482773
func add_player() -> void:
	pass
	
