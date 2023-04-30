class_name MainGameEvents
extends Node

var Envelope: Node
var Package: Node
var ReportPackageButton: Node
var EnvelopeNamePanel: Node
var CustomerName: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Envelope = get_node("%Envelope")
	Package = get_node("%Package")
	ReportPackageButton = get_node("%ReportPackageButton")
	EnvelopeNamePanel = get_node("%EnvelopeNamePanel")
	CustomerName = get_node("%CustomerName")

	Vars.ScanningButton = get_node("%ScanningButton")
	Vars.EndPanel = get_node("%EndPanel")
	Vars.NumEnvelopesSortedNode = get_node("%NumEnvelopesSorted")
	Vars.NumPackagesSortedNode = get_node("%NumPackagesSorted")
	Vars.NumSortingMistakesNode = get_node("%NumSortingMistakes")
	Vars.NumDangerousPackagesSortedNode = get_node("%NumDangerousPackagesSorted")
	Vars.NumDangerousPackageSortingMistakesNode = get_node("%NumDangerousPackageSortingMistakes")
	Vars.NumNotSortedNode = get_node("%NumNotSorted")
	Vars.NumPackagesReportedNode = get_node("%NumPackagesReported")
	Vars.NumPackagesReportedMistakesNode = get_node("%NumPackagesReportedMistakes")
	
	Vars.ClockMinutesNode = get_node("%ClockMinutes")
	Vars.ClockSecondsNode = get_node("%ClockSeconds")

	Vars.TickerData.CurrentMinutesLeft = Vars.PLAY_CLOCK
	Vars.TickerData.GameInProgress = true
	
	CommonUtils.updateDisplayClock()
	
	if Vars.Player.CurrentEnvelope != null:
		var PlayerNameText = str(Vars.Player.CurrentEnvelope.FirstName + " " + Vars.Player.CurrentEnvelope.LastName)

		CustomerName.set_text(PlayerNameText)

		if Vars.Player.CurrentEnvelope.IsPackage == true:
			Vars.ScanningButton.visible = false
			Package.visible = true
			ReportPackageButton.visible = true
		else:
			Envelope.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_rack_slot_pressed():
	var RackSlotId = self.get_meta("RackSlotId")

	if Vars.Player.CurrentEnvelope != null:
		if Vars.Player.CurrentEnvelope.IsPackage == true:
			if Vars.Player.CurrentEnvelope.IsDangerous == true:
				Vars.Player.NumDangerousPackagesSorted += 1

				if Vars.Player.CurrentEnvelope.IsScanned == false || Vars.Player.CurrentEnvelope.Reported == false || RackSlotId != Vars.Player.CurrentEnvelope.RackSlotId:
					Vars.Player.NumDangerousPackageMistakes += 1
					Vars.Player.CustomerComplaintList.append(Vars.Player.CurrentEnvelope)
				else:
					Vars.Player.HappyCustomerList.append(Vars.Player.CurrentEnvelope)
			else:
				Vars.Player.NumPackagesSorted += 1

				if RackSlotId != Vars.Player.CurrentEnvelope.RackSlotId:
					Vars.Player.NumMistakes += 1
					Vars.Player.CustomerComplaintList.append(Vars.Player.CurrentEnvelope)
				else:
					Vars.Player.HappyCustomerList.append(Vars.Player.CurrentEnvelope)

			Vars.ScanningButton.visible = false
			Package.visible = false
			ReportPackageButton.visible = false
		else:
			Vars.Player.NumEnvelopesSorted += 1

			if RackSlotId != Vars.Player.CurrentEnvelope.RackSlotId:
				Vars.Player.NumMistakes += 1
				Vars.Player.CustomerComplaintList.append(Vars.Player.CurrentEnvelope)
			else:
				Vars.Player.HappyCustomerList.append(Vars.Player.CurrentEnvelope)

			Envelope.visible = false 

		Vars.Player.CurrentEnvelope = null

		if Vars.Player.NumEnvelopesAvail <= 0:
			CommonUtils.setEndPanelDisplay()
			Vars.EndPanel.visible = true
			Vars.TickerData.GameInProgress = false
	else:
		print("No evelope available to sort!")


func _on_sorting_bin_pressed():
	if Vars.Player.CurrentEnvelope == null && Vars.Player.NumEnvelopesAvail > 0:
		Vars.Player.CurrentEnvelope = CommonUtils.generateRandomEnvelope()
		Vars.Player.NumEnvelopesAvail -= 1

		var PlayerNameText = str(Vars.Player.CurrentEnvelope.FirstName + " " + Vars.Player.CurrentEnvelope.LastName)

		CustomerName.set_text(PlayerNameText)

		if Vars.Player.CurrentEnvelope.IsPackage == true:
			Vars.ScanningButton.visible = true
			Package.visible = true
		else:
			Envelope.visible = true
	elif Vars.Player.CurrentEnvelope != null:
		print("Need to sort the envelope before getting a new one!")
	else:
		print("No envelopes available!")


func _on_scanning_button_pressed():
	Vars.TickerData.GameInProgress = false
	get_tree().change_scene_to_file("res://Scenes/ScanningRoom.tscn")


func _on_envelope_button_up():
	EnvelopeNamePanel.visible = false


func _on_envelope_button_down():
	EnvelopeNamePanel.visible = true


func _on_report_package_button_pressed():
	Vars.Player.NumPackagesReported += 1
	Vars.Player.CurrentEnvelope.Reported = true

	if Vars.Player.CurrentEnvelope.IsDangerous == false:
		Vars.Player.NumPackagesReportedMistakes += 1

	ReportPackageButton.visible = false
	Package.visible = false
	Vars.Player.CurrentEnvelope = null


func _on_end_shift_pressed():
	if Vars.Player.NumDangerousPackageMistakes > 0 || Vars.Player.NumMistakes > 0 || Vars.Player.NumPackagesReportedMistakes > 0:
		get_tree().change_scene_to_file("res://Scenes/CustomerService.tscn")
