extends Node

var AnsweredGreeting := false
var AnsweredDemand := false


func _on_button_player_response_pressed():
	var ResponseGrade = self.get_meta("ResponseGrade")
	
	if AnsweredGreeting == false && AnsweredDemand == false:
		Vars.Player.CustomerGreetingResponseGrade = ResponseGrade
		AnsweredGreeting = true
	
		CommonUtils.buildPlayerResponses("demand")
	elif AnsweredGreeting == true && AnsweredDemand == false:
		Vars.Player.CustomerDemandResponseGrade = ResponseGrade
		AnsweredDemand = true

		if (Vars.Player.CustomerGreetingResponseGrade == "best" || Vars.Player.CustomerGreetingResponseGrade == "good") && (Vars.Player.CustomerDemandResponseGrade == "best" || Vars.Player.CustomerDemandResponseGrade == "good"):
			Vars.Player.HappyCustomerList.append(Vars.Player.CurrentEnvelope)
		elif (Vars.Player.CustomerGreetingResponseGrade == "worst" || Vars.Player.CustomerGreetingResponseGrade == "bad") && (Vars.Player.CustomerDemandResponseGrade == "worst" || Vars.Player.CustomerDemandResponseGrade == "bad"):
			Vars.Player.AngryCustomerList.append(Vars.Player.CurrentEnvelope)
		else:
			Vars.Player.ContentCustomerList.append(Vars.Player.CurrentEnvelope)
		
		print(Vars.Player.CustomerComplaintList.is_empty())
		print(Vars.Player.CustomerComplaintList.size())
		
		if Vars.Player.CustomerComplaintList.is_empty():
			print("no more complaints")
		else:
			AnsweredGreeting = false
			AnsweredDemand = false
			CommonUtils.getNewRandomCustomer()
			CommonUtils.setCustomerModel()
			CommonUtils.buildPlayerResponses("greeting")

			Vars.CustomerDialogNode.set_text(str("[center]" + Vars.Player.CurrentCustomerDialogTree.CustomerGreetingDialog + "[/center]"))
