extends Node2D

var regex: Object = RegEx.new()

func _ready() -> void:
	var upnp = UPNP.new()
	print("Discover: " + str(upnp.discover()))
	print("Device Count: " + str(upnp.get_device_count()))



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
		#Global.player_name = final
		$NameEntry.visible = false
		$HostJoinMenu.visible = true

func _on_host_button_pressed() -> void:
	$HostJoinMenu.visible = false
	$PreGameLobby.visible = true
	#$PreGameLobby/SelectModeLabel.visible = true
	#$PreGameLobby/OneVOneButton.visible = true
	#$PreGameLobby/FFAButton.visible = true
	#$PreGameLobby/IPLabel.visible = true
	#$PreGameLobby/IPLabel.text = "Your IP address: " + NetworkController.ip_address
	#NetworkController.HostMultiplayer()

func _on_join_button_pressed() -> void:
	$HostJoinMenu.visible = false
	$JoinEntry.visible = true

func _on_address_entry_text_submitted(new_text: String) -> void:
	#NetworkController.JoinMultiplayer(new_text)
	$JoinEntry.visible = false
	$PreGameLobby.visible = true

func _on_je_back_button_pressed() -> void:
	$JoinEntry.visible = false
	$HostJoinMenu.visible = true

func _on_chat_entry_text_submitted(player_name: String, new_text: String) -> void:
	if new_text == "":
		pass
	else:
		#rpc("ChatRPC", Global.player_name, new_text)
		$PreGameLobby/ChatEntry.text = ""

func _on_start_game_button_pressed() -> void:
	pass # Replace with function body.

func _on_blue_button_pressed() -> void:
	pass # Replace with function body.

func _on_red_button_pressed() -> void:
	pass # Replace with function body.

@rpc("any_peer","call_local")
func ChatRPC(player_name,text) -> void:
	$PreGameLobby/ChatBox.text += str(player_name) + ": " + str(text) + "\n"
	$PreGameLobby/ChatBox.scroll_vertical = $PreGameLobby/ChatBox.get_line_count()
