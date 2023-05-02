class_name CustomerServiceEvents
extends Node

var AnsweredGreeting := false
var AnsweredDemand := false

var SoundPlayerNode: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	SoundPlayerNode = get_node("%AudioStreamPlayer")
	SoundController.playSound("buttonpress1", SoundPlayerNode)
	SoundController.playSound("wahwah", SoundPlayerNode)

	CommonUtils.ToastNotifications = preload("res://Scripts/Utilities/ToastNotifications.gd").new()
	CommonUtils.ToastNotifications.ToastNotifcationNode = get_node("%ToastNotificationBackground")
	CommonUtils.ToastNotifications.ToastNotifcationTextNode = get_node("%ToastNotificationText")

	CommonUtils.ToastNotifications.ErrorToastNotifcationNode = get_node("%ErrorToastNotificationBackground")
	CommonUtils.ToastNotifications.ErrorToastNotifcationTextNode = get_node("%ErrorToastNotificationText")

	CommonUtils.ToastNotifications.ToastNotifcationDestinationNode = get_node("%ToastNotificationDestination")

	CommonUtils.ToastNotifications.ToastNotifcationStartingPosition = CommonUtils.ToastNotifications.ToastNotifcationNode.get_position()
	CommonUtils.ToastNotifications.ToastNotifcationDestination = Vector2(CommonUtils.ToastNotifications.ToastNotifcationStartingPosition.x, CommonUtils.ToastNotifications.ToastNotifcationDestinationNode.get_position().y)

	Vars.CustomerModelNode = get_node("%CustomerModel")
	Vars.BestResponseTextNode = get_node("%BestResponseText")
	Vars.GoodResponseTextNode = get_node("%GoodResponseText")
	Vars.BadResponseTextNode = get_node("%BadResponseText")
	Vars.WorstResponseTextNode = get_node("%WorstResponseText")

	Vars.CustomerDialogNode = get_node("%CustomerDialog")

	CommonUtils.getNewRandomCustomer()
	CommonUtils.setCustomerModel()
	CommonUtils.buildPlayerResponses("greeting")

	Vars.CustomerDialogNode.set_text(str("[center]" + Vars.Player.CurrentCustomerDialogTree.CustomerGreetingDialog + "[/center]"))
