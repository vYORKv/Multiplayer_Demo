extends Node

const PORT: int = 2025

var peer: Object

var players: Dictionary = {}

func InitializeNetwork() -> void:
	peer = ENetMultiplayerPeer.new()
	multiplayer.peer_connected.connect(PeerConnected)
	multiplayer.peer_disconnected.connect(PeerDisconnected)
	multiplayer.connected_to_server.connect(ConnectedToServer)
	multiplayer.connection_failed.connect(ConnectionFailed)

func KillNetwork() -> void:
	multiplayer.multiplayer_peer = null
	peer = null

func PeerConnected(id) -> void:
	print("Player Connected: " + str(id))

func PeerDisconnected(id) -> void:
	print("Player Disconnected: " + str(id))
	#players.erase(id)

func ConnectedToServer() -> void:
	print("Connected To Server!")
	rpc("SendPlayerInformation", Global.player_name, multiplayer.get_unique_id())

func ConnectionFailed() -> void:
	print("Couldn't Connect")

func HostMultiplayer() -> void:
	#var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	var id = multiplayer.get_unique_id()
	if !players.has(id):
		players[id] = {
			"id" : id,
			"name" : Global.player_name,
			"color" : ""
		}

func JoinMultiplayer(address: String) -> void:
	peer.create_client(address, PORT)
	multiplayer.multiplayer_peer = peer

@rpc("any_peer")
func SendPlayerInformation(player_name, id) -> void:
	if !players.has(id):
		players[id] = {
			"id" : id,
			"name" : player_name, 
			"color" : ""
		}
	if multiplayer.is_server():
		for i in players:
			rpc("SendPlayerInformation", players[i].name, i)
