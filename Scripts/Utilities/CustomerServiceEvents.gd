class_name CustomerServiceEvents
extends Node

var CustomerDialogNode: Node
var AnsweredGreeting := false
var AnsweredDemand := false


# Called when the node enters the scene tree for the first time.
func _ready():
	Vars.CustomerModelNode = get_node("%CustomerModel")
	Vars.BestResponseTextNode = get_node("%BestResponseText")
	Vars.GoodResponseTextNode = get_node("%GoodResponseText")
	Vars.BadResponseTextNode = get_node("%BadResponseText")
	Vars.WorstResponseTextNode = get_node("%WorstResponseText")
	
	#Vars.BestResponseNode.line_edit = true
	#Vars.GoodResponseNode.line_edit = true
	#Vars.BadResponseNode.line_edit = true
	#Vars.WorstResponseNode.line_edit = true

	CustomerDialogNode = get_node("%CustomerDialog")

	CommonUtils.getNewRandomCustomer()
	CommonUtils.setCustomerModel()
	CommonUtils.buildPlayerResponses("greeting")

	CustomerDialogNode.set_text(str("[center]" + Vars.Player.CurrentCustomerDialogTree.CustomerGreetingDialog + "[/center]"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_player_response_pressed():
	var ResponseGrade = self.get_meta("ResponseGrade")
	
	if AnsweredGreeting == false:
		Vars.Player.CustomerGreetingResponseGrade = ResponseGrade
		AnsweredGreeting = true
	
		CommonUtils.buildPlayerResponses("demand")
	elif AnsweredDemand == false:
		Vars.Player.CustomerDemandResponseGrade = ResponseGrade
		AnsweredDemand = true
	else:
		if (Vars.Player.CustomerGreetingResponseGrade == "best" || Vars.Player.CustomerGreetingResponseGrade == "good") && (Vars.Player.CustomerDemandResponseGrade == "best" || Vars.Player.CustomerDemandResponseGrade == "good"):
			Vars.Player.HappyCustomerList.append(Vars.Player.CurrentEnvelope)
		elif (Vars.Player.CustomerGreetingResponseGrade == "worst" || Vars.Player.CustomerGreetingResponseGrade == "bad") && (Vars.Player.CustomerDemandResponseGrade == "worst" || Vars.Player.CustomerDemandResponseGrade == "bad"):
			Vars.Player.AngryCustomerList.append(Vars.Player.CurrentEnvelope)
		else:
			Vars.Player.ContentCustomerList.append(Vars.Player.CurrentEnvelope)
