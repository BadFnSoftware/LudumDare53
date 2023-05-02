extends Node

var ToastNotifications: ToastNotificationsClass


func getDirectoryContents(path):
	var dir = DirAccess.open(path)
	var contents = []

	if dir:
		dir.list_dir_begin()

		var file_name = dir.get_next()

		while file_name != "":
			if ".import" in file_name:
				file_name = file_name.trim_suffix(".import")

			if ".remap" in file_name:
				file_name = file_name.trim_suffix(".remap")

			contents.append(load(path + "/" + file_name))
			file_name = dir.get_next()
	else:
		CommonUtils.ToastNotifications.ShowErrorToast("An error occurred when trying to access the path: " + path + ".")

	return contents


func getNewRandomCustomer():
	Vars.Player.CurrentCustomerModel = self.generateRandomCustomerModel()
	Vars.Player.CurrentCustomerDialogTree = self.generateRandomCustomerDialogTree()
	Vars.Player.CurrentEnvelope = self.generateRandomComplaintEnvelope()


func generateRandomEnvelope():
	if Vars.Player.AvailEnvelopes.is_empty():
		CommonUtils.ToastNotifications.ShowToast("No envelopes/packages are left!")
		return null
	else:
		var maxRng = Vars.Player.AvailEnvelopes.size() - 1
		var rng = RandomNumberGenerator.new()
		var index = rng.randi_range(0, maxRng)
		var randomEnvelope = Vars.Player.AvailEnvelopes[index]

		if maxRng > 0:
			Vars.Player.AvailEnvelopes.remove_at(index)
		else:
			Vars.Player.AvailEnvelopes = []

		return randomEnvelope


func generateRandomComplaintEnvelope():
	if Vars.Player.CustomerComplaintList.is_empty():
		CommonUtils.ToastNotifications.ShowToast("No complaints are left!")
		return null
	else:
		var maxRng = Vars.Player.CustomerComplaintList.size() - 1
		var rng = RandomNumberGenerator.new()
		var index = rng.randi_range(0, maxRng)
		var randomEnvelope = Vars.Player.CustomerComplaintList[index]

		if maxRng > 0:
			Vars.Player.CustomerComplaintList.remove_at(index)
		else:
			Vars.Player.CustomerComplaintList = []

		return randomEnvelope


func generateRandomCustomerModel():
	if Vars.Player.AvailCustomerModels.is_empty():
		CommonUtils.ToastNotifications.ShowErrorToast("No customer models are avail!")
		return null
	else:
		var maxRng = Vars.Player.AvailCustomerModels.size() - 1
		var rng = RandomNumberGenerator.new()
		var index = rng.randi_range(0, maxRng)
		var randomCustomer = Vars.Player.AvailCustomerModels[index]

		return randomCustomer


func generateRandomCustomerDialogTree():
	if Vars.Player.AvailCustomerDialogTrees.is_empty():
		CommonUtils.ToastNotifications.ShowErrorToast("No customer dialogs are avail!")
		return null
	else:
		var maxRng = Vars.Player.AvailCustomerDialogTrees.size() - 1
		var rng = RandomNumberGenerator.new()
		var index = rng.randi_range(0, maxRng)
		var randomCustomer = Vars.Player.AvailCustomerDialogTrees[index]
		
		Vars.Player.AvailCustomerDialogTrees.remove_at(index)

		return randomCustomer


func gatherAllEnvelopes():
	var path = "res://Resources/Envelopes/"
	var availEnvelopes = self.getDirectoryContents(path)

	if availEnvelopes.is_empty():
		CommonUtils.ToastNotifications.ShowErrorToast("No avail envelopes!")
		return []
	else:
		return availEnvelopes


func gatherAllCustomerModels():
	var path = "res://Assets/CustomerModels/"
	var AvailCustomerModels = self.getDirectoryContents(path)

	if AvailCustomerModels.is_empty():
		CommonUtils.ToastNotifications.ShowErrorToast("No avail customer models!")
		return []
	else:
		return AvailCustomerModels


func gatherAllCustomerDialogTrees():
	var path = "res://Resources/CustomerDialogTrees/"
	var AvailCustomerDialogTrees = self.getDirectoryContents(path)

	if AvailCustomerDialogTrees.is_empty():
		CommonUtils.ToastNotifications.ShowErrorToast("No avail customer dialogs!")
		return []
	else:
		return AvailCustomerDialogTrees


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


func setEndGameDisplay():
	Vars.EndGameNumEnvelopesSortedNode.set_text(str(Vars.Player.NumEnvelopesSorted))
	Vars.EndGameNumPackagesSortedNode.set_text(str(Vars.Player.NumPackagesSorted))
	Vars.EndGameNumSortingMistakesNode.set_text(str(Vars.Player.NumMistakes))
	Vars.EndGameNumDangerousPackagesSortedNode.set_text(str(Vars.Player.NumDangerousPackagesSorted))
	Vars.EndGameNumDangerousPackageSortingMistakesNode.set_text(str(Vars.Player.NumDangerousPackageMistakes))
	Vars.EndGameNumPackagesReportedNode.set_text(str(Vars.Player.NumPackagesReported))
	Vars.EndGameNumPackagesReportedMistakesNode.set_text(str(Vars.Player.NumPackagesReportedMistakes))
	Vars.EndGameNumHappyCustomersNode.set_text(str(Vars.Player.NumHappyCustomers))
	Vars.EndGameNumContentCustomersNode.set_text(str(Vars.Player.NumContentCustomers))
	Vars.EndGameNumAngryCustomersNode.set_text(str(Vars.Player.NumAngryCustomers))

	if Vars.Player.NumEnvelopesAvail > 0:
		Vars.EndGameNumNotSortedNode.set_text(str(Vars.Player.NumEnvelopesAvail))
	
	Vars.EndGameOverallGradeNode.set_text(str(Vars.EndGameOverallGrade))
	
	if Vars.EndGameIsFired == true:
		Vars.EndGameYourFiredTextNode.visible = true


func setCustomerModel():
	Vars.CustomerModelNode.texture = Vars.Player.CurrentCustomerModel


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


func buildPlayerResponses(type):
	if type == "greeting":
		Vars.BestResponseTextNode.text = "[center]" + str(Vars.Player.CurrentCustomerDialogTree.GreetingBestResponse) + "[/center]"
		Vars.GoodResponseTextNode.text = "[center]" + str(Vars.Player.CurrentCustomerDialogTree.GreetingGoodResponse) + "[/center]"
		Vars.BadResponseTextNode.text = "[center]" + str(Vars.Player.CurrentCustomerDialogTree.GreetingBadResponse) + "[/center]"
		Vars.WorstResponseTextNode.text = "[center]" + str(Vars.Player.CurrentCustomerDialogTree.GreetingWorstResponse) + "[/center]"
	elif type == "demand":
		Vars.BestResponseTextNode.text = "[center]" + str(Vars.Player.CurrentCustomerDialogTree.DemandBestResponse) + "[/center]"
		Vars.GoodResponseTextNode.text = "[center]" + str(Vars.Player.CurrentCustomerDialogTree.DemandGoodResponse) + "[/center]"
		Vars.BadResponseTextNode.text = "[center]" + str(Vars.Player.CurrentCustomerDialogTree.DemandBadResponse) + "[/center]"
		Vars.WorstResponseTextNode.text = "[center]" + str(Vars.Player.CurrentCustomerDialogTree.DemandWorstResponse) + "[/center]"
