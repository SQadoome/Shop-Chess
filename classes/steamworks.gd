extends SceneChanger

var lobby_id: int = 0;

signal lobby_created(id: int)

func _ready() -> void:
	_initilize_steam();
	
	Steam.lobby_created.connect(_on_lobby_created);
	

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
	var lobby_name: String = Steam.getPersonaName();
	
	if (not Steam.setLobbyData(lobby_id, "lobby_name", lobby_name)):
		assert(false, "Failed to set lobby_data");
	
	lobby_created.emit(_lobby_id);
	

func leave_lobby() -> void:
	if (lobby_id != 0):
		printerr("Application terminated, left steam lobby.")
		Steam.leaveLobby(lobby_id);
		
	

func _process(_delta: float) -> void:
	Steam.run_callbacks();
	
