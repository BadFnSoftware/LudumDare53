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
		
		Vars.AvailCustomers.remove(index)

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


func getGenderFromCustomerEnvelope():
	return Vars.GenderTypes.keys()[Vars.Player.CurrentEnvelope.Gender]
