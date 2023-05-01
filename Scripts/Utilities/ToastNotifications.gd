class_name ToastNotificationsClass
extends Node

var ElapsedTime := 0.0
var IsVisible := false
var IsActive := false
var IsError := false
var IsWaiting := false

var ToastNotifcationNode: Node
var ErrorToastNotifcationNode: Node
var ToastNotifcationTextNode: Node
var ErrorToastNotifcationTextNode: Node
var ToastNotifcationDestinationNode: Node

var ToastNotifcationDestination: Vector2
var ToastNotifcationStartingPosition: Vector2


func ShowToast(message):
	if IsActive == false:
		ToastNotifcationTextNode.set_text("[center]" + str(message) + "[/center]")
		IsActive = true


func ShowErrorToast(message):
	if IsActive == false:
		ErrorToastNotifcationTextNode.set_text("[center]" + str(message) + "[/center]")
		IsError = true
		IsActive = true
