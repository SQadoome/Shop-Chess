class_name SceneHandler
extends Node2D

var player_1
var player_2

@export var menu: Control

static var instance: SceneHandler

func _enter_tree() -> void:
	if (instance == null):
		instance = self;
	else:
		assert(false, "Singleton violation");
	

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
func start_game(p1: int, p2: int) -> void:
	print("Yooooo");
	
