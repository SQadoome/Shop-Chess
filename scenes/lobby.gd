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
	Steam.avatar_loaded.connect(_set_avatar);
	
	$Button.pressed.connect(_update_ready);

func _set_avatar(player_id: int, _size: int, data: Array) -> void:
	for index:int in players.size():
		var p_data: PlayerData = players[index];
		
		if (p_data.steam_id == player_id):
			var pfp_image: Image = Image.create_from_data(
				_size, _size, false, Image.FORMAT_RGBA8, data
			);
			var pfp_texture: Texture2D = ImageTexture.create_from_image(pfp_image);
			
			p_data.pfp = pfp_texture;
		
	_set_players();

func _update_ready() -> void:
	var old_value: String = Steam.getLobbyMemberData(
		Steamworks.lobby_id, Steam.getSteamID(), "ready"
	);
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
		p_data.steam_id = p_id;
		players[index] = p_data;
		
		Steam.getPlayerAvatar(Steam.AVATAR_MEDIUM, p_id);
		
	

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
	
	for data:PlayerData in players:
		if (data.ready_value == false):
			return;
		
	
	_start_game();
	

func _start_game() -> void:
	$Button.hide();
	$StartTimer.start();
	
	$StartTimer.finished.connect(func() -> void:
		SceneHandler.instance.start_game(1, 1))
	
