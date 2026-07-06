class_name PlayerData
extends Resource

var username: String
var pfp: Texture
var position_in_lobby: int
var ready_value: bool

const DEFAULT_PFP: Texture = preload("res://icon.svg");

func _init() -> void:
	pfp = DEFAULT_PFP;
	

func set_ready(ready_str: String) -> void:
	ready_value = (ready_str == "true");
	
