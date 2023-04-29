extends Node

var Envelope: Node
var Package: Node
var ScanningButton: Node
var ScanningButtonDisabled: Node
var EnvelopeNamePanel: Node
var CustomerName: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Envelope = get_node("%Envelope")
	Package = get_node("%Package")
	ScanningButton = get_node("%ScanningButton")
	ScanningButtonDisabled = get_node("%ScanningButtonDisabled")
	EnvelopeNamePanel = get_node("%EnvelopeNamePanel")
	CustomerName = get_node("%CustomerName")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_rack_slot_pressed():
	var RackSlotId = self.get_meta("RackSlotId")
	
	if Vars.Player.CurrentEnvelope != null:
		Vars.Player.NumEnvelopesSorted += 1
	
		if RackSlotId != Vars.Player.CurrentEnvelope.RackSlotId:
			Vars.Player.NumMistakes += 1
		
		if Vars.Player.CurrentEnvelope.IsPackage == true:
			ScanningButton.visible = false
			ScanningButtonDisabled.visible = true
			Package.visible = false
			
			if Vars.Player.CurrentEnvelope.IsDangerous == true:
				Vars.Player.NumDangerousPackagesSorted += 1
				
				if Vars.Player.CurrentEnvelope.IsScanned == false:
					Vars.Player.NumDangerousPackageMistakes += 1
		else:
			Envelope.visible = false
		
		Vars.Player.CurrentEnvelope = null
	else:
		print("No evelope available to sort!")


func _on_sorting_bin_pressed():
	if Vars.Player.CurrentEnvelope == null && Vars.Player.NumEnvelopesAvail > 0:
		Vars.Player.CurrentEnvelope = CommonUtils.generateRandomEnvelope()
		Vars.Player.NumEnvelopesAvail -= 1

		var PlayerNameText = str(Vars.Player.CurrentEnvelope.FirstName + " " + Vars.Player.CurrentEnvelope.LastName)

		CustomerName.set_text(PlayerNameText)

		if Vars.Player.CurrentEnvelope.IsPackage == true:
			ScanningButton.visible = true
			ScanningButtonDisabled.visible = false
			Package.visible = true
		else:
			Envelope.visible = true
	elif Vars.Player.CurrentEnvelope != null:
		print("Need to sort the envelope before getting a new one!")
	else:
		print("No envelopes available!")


func _on_scanning_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ScanningRoom.tscn")


func _on_envelope_button_up():
	EnvelopeNamePanel.visible = false


func _on_envelope_button_down():
	EnvelopeNamePanel.visible = true
