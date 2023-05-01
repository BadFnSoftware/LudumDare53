class_name CustomerServiceEvents
extends Node

var AnsweredGreeting := false
var AnsweredDemand := false


# Called when the node enters the scene tree for the first time.
func _ready():
	Vars.CustomerModelNode = get_node("%CustomerModel")
	Vars.BestResponseTextNode = get_node("%BestResponseText")
	Vars.GoodResponseTextNode = get_node("%GoodResponseText")
	Vars.BadResponseTextNode = get_node("%BadResponseText")
	Vars.WorstResponseTextNode = get_node("%WorstResponseText")

	print(Vars.Player.CustomerComplaintList.size())

	Vars.CustomerDialogNode = get_node("%CustomerDialog")

	CommonUtils.getNewRandomCustomer()
	CommonUtils.setCustomerModel()
	CommonUtils.buildPlayerResponses("greeting")

	Vars.CustomerDialogNode.set_text(str("[center]" + Vars.Player.CurrentCustomerDialogTree.CustomerGreetingDialog + "[/center]"))
