extends Node

var Envelope: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Envelope = get_node("%Envelope")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_rack_slot_pressed():
	var RackSlotId = self.get_meta("RackSlotId")
	
	if Vars.Player.CurrentEnvelope != null:
		Vars.Player.NumEnvelopesSorted += 1
	
		if RackSlotId != Vars.Player.CurrentEnvelope.RackSlotId:
			Vars.Player.NumMistakes += 1

		Vars.Player.CurrentEnvelope = null
		Envelope.visible = false
	else:
		print("No evelope available to sort!")


func _on_sorting_bin_pressed():
	if Vars.Player.CurrentEnvelope == null && Vars.Player.NumEnvelopesAvail > 0:
		Vars.Player.CurrentEnvelope = CommonUtils.generateRandomEnvelope()
		Vars.Player.NumEnvelopesAvail -= 1
		Envelope.visible = true
	elif Vars.Player.CurrentEnvelope != null:
		print("Need to sort the envelope before getting a new one!")
	else:
		print("No envelopes available!")
