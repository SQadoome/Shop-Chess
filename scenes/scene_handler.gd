extends Node2D

var player_1
var player_2

@export var menu: Control

func _ready() -> void:
	menu.change_scene.connect(_change_menu)
	

func _change_menu(scene: PackedScene) -> void:
	if (menu != null):
		menu.queue_free();
	
	var new_instance: SceneChanger = scene.instantiate();
	menu = new_instance;
	$CanvasLayer.add_child(new_instance);
	menu.change_scene.connect(_change_menu);
	

@rpc("authority", "call_local", "reliable")
func _start_game(p1, p2) -> void:
	player_1 = p1
	player_2 = p2
	var new_game = load("res://scenes/game_handler.tscn").instantiate()
	if multiplayer.is_server():
		new_game.player_team = 0
	else:
		new_game.player_team = 1
	get_node("CanvasLayer").queue_free()
	add_child(new_game)
	new_game._display_usernames(p1, p2)
	
