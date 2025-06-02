extends Node2D

var regex: Object = RegEx.new()

func _ready() -> void:
	#var upnp = UPNP.new()
	#print("Discover: " + str(upnp.discover()))
	#print("Device Count: " + str(upnp.get_device_count()))
	NetworkController.InitializeNetwork()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/menu_scenes/main_menu.tscn")

func _on_name_submission_text_submitted(new_text: String) -> void:
	var lower: String = new_text.to_lower()
	regex.compile("[^a-z]")
	var cleaned: String = regex.sub(lower, "", true)
	var final: String = cleaned.capitalize()
	if final == "":
		$NameEntry/Label2.visible = true
	else:
		Global.player_name = final
		$NameEntry.visible = false
		$HostJoinMenu.visible = true

func _on_host_button_pressed() -> void:
	$HostJoinMenu.visible = false
	$HostConfirmation.visible = true
	#$PreGameLobby/SelectModeLabel.visible = true
	#$PreGameLobby/OneVOneButton.visible = true
	#$PreGameLobby/FFAButton.visible = true
	#$PreGameLobby/IPLabel.visible = true
	#$PreGameLobby/IPLabel.text = "Your IP address: " + NetworkController.ip_address
	NetworkController.HostMultiplayer()

func _on_join_button_pressed() -> void:
	$HostJoinMenu.visible = false
	$JoinEntry.visible = true

func _on_address_entry_text_submitted(new_text: String) -> void:
	NetworkController.JoinMultiplayer(new_text)
	$JoinEntry.visible = false
	$PreGameLobby.visible = true

func _on_je_back_button_pressed() -> void:
	$JoinEntry.visible = false
	$HostJoinMenu.visible = true

func _on_chat_entry_text_submitted(new_text: String) -> void:
	if new_text == "":
		pass
	else:
		rpc("ChatRPC", Global.player_name, new_text)
		$PreGameLobby/ChatEntry.text = ""

func _on_start_game_button_pressed() -> void:
	print(NetworkController.players)

func _on_blue_button_pressed() -> void:
	print("Name: " + str(Global.player_name))
	print("MP ID: " + str(multiplayer.get_unique_id()))
	print("Is server: " + str(multiplayer.is_server()))
	if Global.color != "":
		pass
	else:
		Global.color = "blue"
		rpc("BluePlayer", Global.player_name, multiplayer.get_unique_id())
	print("Color: " + str(Global.color))

func _on_red_button_pressed() -> void:
	print("Name: " + str(Global.player_name))
	print("MP ID: " + str(multiplayer.get_unique_id()))
	print("Is server: " + str(multiplayer.is_server()))
	if Global.color != "":
		pass
	else:
		Global.color = "red"
		rpc("RedPlayer", Global.player_name, multiplayer.get_unique_id())
	print("Color: " + str(Global.color))

@rpc("any_peer","call_local")
func BluePlayer(player_name, id) -> void:
	$PreGameLobby/BlueButton.visible = false
	$PreGameLobby/BlueLabel.text = player_name
	if multiplayer.is_server():
		NetworkController.players[id].color = "blue"

@rpc("any_peer","call_local")
func RedPlayer(player_name, id) -> void:
	$PreGameLobby/RedButton.visible = false
	$PreGameLobby/RedLabel.text = player_name
	if multiplayer.is_server():
		NetworkController.players[id].color = "red"

@rpc("any_peer","call_local")
func ChatRPC(player_name,text) -> void:
	$PreGameLobby/ChatBox.text += str(player_name) + ": " + str(text) + "\n"
	$PreGameLobby/ChatBox.scroll_vertical = $PreGameLobby/ChatBox.get_line_count()

func _on_continue_button_pressed() -> void:
	$HostConfirmation.visible = false
	$PreGameLobby.visible = true
	# Likely call network initialization function from Network Controller

func _on_hc_back_button_pressed() -> void:
	pass # Replace with function body.

func _on_ip_button_pressed() -> void:
	$PreGameLobby/IPButton.visible = false
	$PreGameLobby/IPLabel.visible = true
