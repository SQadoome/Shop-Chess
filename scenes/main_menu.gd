class_name MainMenu
extends Control

@export var host_button: Button;
@export var join_button: Button;

signal change_scene(new_scene: PackedScene);

const host_menu: PackedScene = preload("res://scenes/hosted_lobby.tscn");
const join_menu: PackedScene = preload("res://scenes/lobby_browser.tscn");

func _ready() -> void:
	host_button.pressed.connect(_on_host_pressed);
	join_button.pressed.connect(_on_join_pressed)
	

func _on_host_pressed() -> void:
	Steamworks.create_lobby();
	change_scene.emit(host_menu);
	

func _on_join_pressed() -> void:
	change_scene.emit(join_menu);
	
