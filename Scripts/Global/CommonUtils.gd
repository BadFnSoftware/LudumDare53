extends Node


func getDirectoryContents(path):
	var dir = DirAccess.open(path)
	var contents = []

	if dir:
		dir.list_dir_begin()

		var file_name = dir.get_next()

		while file_name != "":
			contents.append(load(path + "/" + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path: " + path + ".")

	return contents


func generateRandomEnvelope():
	if Vars.Player.AvailEnvelopes.is_empty():
		print("No envelopes/packages are left!")
		return null
	else:
		var maxRng = Vars.Player.AvailEnvelopes.size() - 1
		var rng = RandomNumberGenerator.new()
		var index = rng.randi_range(0, maxRng)
		var randomEnvelope = Vars.Player.AvailEnvelopes[index]

		if maxRng > 0:
			Vars.Player.AvailEnvelopes.remove_at (index)
		else:
			Vars.Player.AvailEnvelopes = []

		return randomEnvelope


func generateRandomCustomer():
	if Vars.AvailCustomers.is_empty():
		print("No customer models are avail!")
		return null
	else:
		var maxRng = Vars.AvailCustomers.size() - 1
		var rng = RandomNumberGenerator.new()
		var index = rng.randi_range(0, maxRng)
		var randomCustomer = Vars.AvailCustomers[index]

		if maxRng == 0:
			Vars.Player.AvailCustomers = []
		else:
			Vars.Player.AvailCustomers.remove_at (index)

		return randomCustomer


func gatherAllEnvelopes():
	var path = "res://Resources/Envelopes/"
	var availEnvelopes = self.getDirectoryContents(path)

	if availEnvelopes.is_empty():
		print("Error gathering available envelopes, came up empty...")
		return []
	else:
		return availEnvelopes


func gatherAllCustomerModels():
	var path = "res://Assets/Customers/"
	var availCustomers = self.getDirectoryContents(path)

	if availCustomers.is_empty():
		print("Error gathering available customers, came up empty...")
		return []
	else:
		return availCustomers


func setEndPanelDisplay():
	Vars.NumEnvelopesSortedNode.set_text(str(Vars.Player.NumEnvelopesSorted))
	Vars.NumPackagesSortedNode.set_text(str(Vars.Player.NumPackagesSorted))
	Vars.NumSortingMistakesNode.set_text(str(Vars.Player.NumMistakes))
	Vars.NumDangerousPackagesSortedNode.set_text(str(Vars.Player.NumDangerousPackagesSorted))
	Vars.NumDangerousPackageSortingMistakesNode.set_text(str(Vars.Player.NumDangerousPackageMistakes))
	Vars.NumPackagesReportedNode.set_text(str(Vars.Player.NumPackagesReported))
	Vars.NumPackagesReportedMistakesNode.set_text(str(Vars.Player.NumPackagesReportedMistakes))
	
	if Vars.Player.NumEnvelopesAvail > 0:
		Vars.NumNotSortedNode.set_text(str(Vars.Player.NumEnvelopesAvail))


func updateDisplayClock():
	var minutesLeft: String
	var secondsLeft: String

	if Vars.TickerData.CurrentMinutesLeft < 10:
		minutesLeft = "0" + str(Vars.TickerData.CurrentMinutesLeft)
	else:
		minutesLeft = str(Vars.TickerData.CurrentMinutesLeft)

	if Vars.TickerData.CurrentSecondsLeft < 10:
		secondsLeft = "0" + str(Vars.TickerData.CurrentSecondsLeft)
	else:
		secondsLeft = str(Vars.TickerData.CurrentSecondsLeft)

	var minuteText = "[center]" + str(minutesLeft) + "[/center]"
	var secondText = "[center]" + str(secondsLeft) + "[/center]"

	Vars.ClockMinutesNode.set_text(str(minuteText))
	Vars.ClockSecondsNode.set_text(str(secondText))
