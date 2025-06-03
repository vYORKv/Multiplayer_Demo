extends Node2D

const PLAYER: Object = preload("res://scenes/actor_scenes/player.tscn")
const SPECTATOR: Object = preload("res://scenes/actor_scenes/spectator_camera.tscn")

@onready var BlueSpawn: Marker2D = $BlueSpawn
@onready var RedSpawn: Marker2D = $RedSpawn
@onready var SpectatorSpawn: Marker2D = $SpectatorSpawn

func _ready() -> void:
	if Global.color != "":
		SpawnPlayer()
	else:
		SpawnSpectator()

func SpawnPlayer() -> void:
	var player: Object = PLAYER.instantiate()
	add_child(player)
	if Global.color == "blue":
		player.position = BlueSpawn.global_position
	elif Global.color == "red":
		player.position = RedSpawn.global_position

func SpawnSpectator() -> void:
	var spectator: Object = SPECTATOR.instantiate()
	add_child(spectator)
	spectator.position = SpectatorSpawn.global_position
