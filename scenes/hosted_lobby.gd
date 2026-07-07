extends SceneChanger

const LOBBY_SCENE: PackedScene = preload("res://scenes/lobby.tscn");

func _ready() -> void:
	Steamworks.lobby_created.connect(
		func(id: int) -> void:
			$ColorRect/Code/Label.text = "Code: " + str(id)
			Steam.setLobbyMemberData(
			Steamworks.lobby_id,
			"username",
			Steam.getPersonaName(),
			)
			Steam.setLobbyMemberData(
			Steamworks.lobby_id,
			"ready",
			"false",
			)
	);
	Steam.lobby_data_update.connect(
		func(success: int, lb: int, p: int) -> void:
			if (Steam.getNumLobbyMembers(Steamworks.lobby_id) > 1):
				_on_player_joined();
	);
	
	

func _on_player_joined() -> void:
	change_scene.emit(LOBBY_SCENE);
	

func _on_lobby_created(lobby_id: int) -> void:
	$ColorRect/Code/Label.text = "Code: " + str(lobby_id);
	Steam.setLobbyMemberData(
		lobby_id, "username", Steam.getPersonaName());
	
	Steam.setLobbyMemberData(
		lobby_id, "ready", "false");
	
