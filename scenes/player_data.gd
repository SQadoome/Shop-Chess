class_name PlayerData
extends Resource

var username: String
var pfp: Texture
var position_in_lobby: int

const DEFAULT_PFP: Texture = preload("res://icon.svg");

func _init() -> void:
	pfp = DEFAULT_PFP;
	
