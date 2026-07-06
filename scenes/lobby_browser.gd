extends SceneChanger

const LOBBY_SCENE: PackedScene = preload("res://scenes/lobby.tscn");

func _ready() -> void:
	Steam.lobby_joined.connect(_on_lobby_joined)
	$Buttons/Join.pressed.connect(_on_join_pressed)
	

func _on_lobby_joined(lobby: int, permissions: int, locked: bool, response: int) -> void:
	match response:
		Steam.Result.RESULT_OK:
			_join_successfull();
		_:
			_join_failed();
	

func _join_successfull() -> void:
	change_scene.emit(LOBBY_SCENE);
	$FailLabel.hide();
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
	

func _join_failed():
	$FailLabel.show();
	

func _on_join_pressed() -> void:
	var lobby_id: int = $Code/TextEdit.text.to_int();
	Steam.joinLobby(lobby_id);
	
	
