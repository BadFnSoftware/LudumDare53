extends Node

var AnsweredGreeting := false
var AnsweredDemand := false


# Called when the node enters the scene tree for the first time.
func _ready():
	CommonUtils.ToastNotifications = preload("res://Scripts/Utilities/ToastNotifications.gd").new()
	CommonUtils.ToastNotifications.ToastNotifcationNode = get_node("%ToastNotificationBackground")
	CommonUtils.ToastNotifications.ToastNotifcationTextNode = get_node("%ToastNotificationText")

	CommonUtils.ToastNotifications.ErrorToastNotifcationNode = get_node("%ErrorToastNotificationBackground")
	CommonUtils.ToastNotifications.ErrorToastNotifcationTextNode = get_node("%ErrorToastNotificationText")

	CommonUtils.ToastNotifications.ToastNotifcationDestinationNode = get_node("%ToastNotificationDestination")

	CommonUtils.ToastNotifications.ToastNotifcationStartingPosition = CommonUtils.ToastNotifications.ToastNotifcationNode.get_position()
	CommonUtils.ToastNotifications.ToastNotifcationDestination = Vector2(CommonUtils.ToastNotifications.ToastNotifcationStartingPosition.x, CommonUtils.ToastNotifications.ToastNotifcationDestinationNode.get_position().y)


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
		
		if Vars.Player.CustomerComplaintList.is_empty():
			CommonUtils.ToastNotifications.ShowToast("No more complaints left!")
			get_tree().change_scene_to_file("res://Scenes/End.tscn")
		else:
			AnsweredGreeting = false
			AnsweredDemand = false
			CommonUtils.getNewRandomCustomer()
			CommonUtils.setCustomerModel()
			CommonUtils.buildPlayerResponses("greeting")

			Vars.CustomerDialogNode.set_text(str("[center]" + Vars.Player.CurrentCustomerDialogTree.CustomerGreetingDialog + "[/center]"))
