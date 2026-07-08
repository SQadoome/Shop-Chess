extends SceneChanger

var lobby_id: int = 0;
var peer: MultiplayerPeer;
var steam_id: int;

signal lobby_created(id: int)

func _ready() -> void:
	_initilize_steam();
	
	Steam.lobby_created.connect(_on_lobby_created);
	Steam.lobby_joined.connect(_on_lobby_joined);
	

func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_WM_CLOSE_REQUEST:
		leave_lobby();
	

func _initilize_steam() -> void:
	var init_response: Dictionary = Steam.steamInitEx(480);
	
	print("--Steam initilization--");
	print(init_response);
	print("----");
	
	var ok_result: Steam.SteamAPIInitResult = \
		Steam.SteamAPIInitResult.STEAM_API_INIT_RESULT_OK;
	
	if init_response["status"] != ok_result:
		printerr("Failed to initilize steam.");
		printerr("Error status: ", init_response["status"]);
		printerr("error message: ", init_response["verbal"]);
		
		assert(false);
		
	
	steam_id = Steam.getSteamID();
	

func join_lobby(lobby: int) -> void:
	Steam.joinLobby(lobby);
	lobby_id = lobby;
	
 
func _on_lobby_joined(lobby: int, permissions: int, locked: bool, response: int) -> void:
	if (response == Steam.RESULT_OK):
		lobby_id = lobby;
		
		if (Steam.getLobbyOwner(lobby_id) != steam_id):
			peer = SteamMultiplayerPeer.new();
			var server_id: int = Steam.getLobbyOwner(lobby_id);
			var creation_result: int = peer.create_client(server_id);
			assert(creation_result == Error.OK);
			peer.server_relay = true;
			multiplayer.set_multiplayer_peer(peer);
		
	
	

func create_lobby() -> void:
	const MAX_PLAYERS: int = 2;
	const VISIBILITY: Steam.LobbyType = Steam.LOBBY_TYPE_PUBLIC;
	
	Steam.createLobby(VISIBILITY, MAX_PLAYERS);
	

func _on_lobby_created(con_status: Steam.Result, _lobby_id: int) -> void:
	if (con_status != Steam.Result.RESULT_OK):
		printerr("--Failed to create lobby--");
		print("Steam Result: ", con_status);
		return;
	
	lobby_id = _lobby_id;
	
	lobby_created.emit(_lobby_id);
	await get_tree().create_timer(1.0).timeout
	if (Steam.getLobbyOwner(lobby_id) == steam_id):
		peer = SteamMultiplayerPeer.new();
		var hosting_result: Error = peer.create_host();
		printerr(hosting_result);
		assert(hosting_result == Error.OK);
		peer.server_relay = true;
		multiplayer.set_multiplayer_peer(peer);
	

func leave_lobby() -> void:
	if (lobby_id != 0):
		printerr("Application terminated, left steam lobby.")
		Steam.leaveLobby(lobby_id);
		
	

func _process(_delta: float) -> void:
	Steam.run_callbacks();
	
