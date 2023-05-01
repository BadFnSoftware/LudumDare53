class_name UpdateJobFuncsClass
extends Node


func processToastNotifications():
	if CommonUtils.ToastNotifications.IsActive == true:
		CommonUtils.ToastNotifications.ElapsedTime += Vars.TickerData.TickDelta
	
		if CommonUtils.ToastNotifications.IsVisible == false && CommonUtils.ToastNotifications.IsError == false && CommonUtils.ToastNotifications.ToastNotifcationNode.get_position().y > CommonUtils.ToastNotifications.ToastNotifcationDestination.y:
			CommonUtils.ToastNotifications.ToastNotifcationNode.position = CommonUtils.ToastNotifications.ToastNotifcationStartingPosition.lerp(CommonUtils.ToastNotifications.ToastNotifcationDestination, CommonUtils.ToastNotifications.ElapsedTime)
		elif CommonUtils.ToastNotifications.IsVisible == false && CommonUtils.ToastNotifications.IsError == false && CommonUtils.ToastNotifications.ToastNotifcationNode.get_position().y <= CommonUtils.ToastNotifications.ToastNotifcationDestination.y:
			CommonUtils.ToastNotifications.IsVisible = true
			CommonUtils.ToastNotifications.IsWaiting = true
			CommonUtils.ToastNotifications.ElapsedTime = 0.0
		elif CommonUtils.ToastNotifications.IsVisible == false && CommonUtils.ToastNotifications.IsError == true && CommonUtils.ToastNotifications.ErrorToastNotifcationNode.get_position().y > CommonUtils.ToastNotifications.ToastNotifcationDestination.y:
			CommonUtils.ToastNotifications.ErrorToastNotifcationNode.position = CommonUtils.ToastNotifications.ToastNotifcationStartingPosition.lerp(CommonUtils.ToastNotifications.ToastNotifcationDestination, CommonUtils.ToastNotifications.ElapsedTime)
		elif CommonUtils.ToastNotifications.IsVisible == false && CommonUtils.ToastNotifications.IsError == true && CommonUtils.ToastNotifications.ErrorToastNotifcationNode.get_position().y <= CommonUtils.ToastNotifications.ToastNotifcationDestination.y:
			CommonUtils.ToastNotifications.IsVisible = true
			CommonUtils.ToastNotifications.IsWaiting = true
			CommonUtils.ToastNotifications.ElapsedTime = 0.0

		if CommonUtils.ToastNotifications.IsWaiting == false && CommonUtils.ToastNotifications.IsVisible == true && CommonUtils.ToastNotifications.IsError == false && CommonUtils.ToastNotifications.ToastNotifcationNode.get_position().y < CommonUtils.ToastNotifications.ToastNotifcationStartingPosition.y:
			CommonUtils.ToastNotifications.ToastNotifcationNode.position = CommonUtils.ToastNotifications.ToastNotifcationDestination.lerp(CommonUtils.ToastNotifications.ToastNotifcationStartingPosition, CommonUtils.ToastNotifications.ElapsedTime)
		elif CommonUtils.ToastNotifications.IsWaiting == false && CommonUtils.ToastNotifications.IsVisible == true && CommonUtils.ToastNotifications.IsError == false && CommonUtils.ToastNotifications.ToastNotifcationNode.get_position().y >= CommonUtils.ToastNotifications.ToastNotifcationStartingPosition.y:
			CommonUtils.ToastNotifications.IsActive = false
			CommonUtils.ToastNotifications.IsVisible = false
			CommonUtils.ToastNotifications.ElapsedTime = 0.0
		elif CommonUtils.ToastNotifications.IsWaiting == false && CommonUtils.ToastNotifications.IsVisible == true && CommonUtils.ToastNotifications.IsError == true && CommonUtils.ToastNotifications.ErrorToastNotifcationNode.get_position().y < CommonUtils.ToastNotifications.ToastNotifcationStartingPosition.y:
			CommonUtils.ToastNotifications.ErrorToastNotifcationNode.position = CommonUtils.ToastNotifications.ToastNotifcationDestination.lerp(CommonUtils.ToastNotifications.ToastNotifcationStartingPosition, CommonUtils.ToastNotifications.ElapsedTime)
		elif CommonUtils.ToastNotifications.IsWaiting == false && CommonUtils.ToastNotifications.IsVisible == true && CommonUtils.ToastNotifications.IsError == true && CommonUtils.ToastNotifications.ErrorToastNotifcationNode.get_position().y >= CommonUtils.ToastNotifications.ToastNotifcationStartingPosition.y:
			CommonUtils.ToastNotifications.IsActive = false
			CommonUtils.ToastNotifications.IsVisible = false
			CommonUtils.ToastNotifications.IsError = false
			CommonUtils.ToastNotifications.ElapsedTime = 0.0

		if CommonUtils.ToastNotifications.IsWaiting == true && CommonUtils.ToastNotifications.IsVisible == true && Vars.ToastWaitTimeRemaining > 0:
			Vars.ToastWaitTimeRemaining -= Vars.TickerData.TickDelta
		elif CommonUtils.ToastNotifications.IsWaiting == true && CommonUtils.ToastNotifications.IsVisible == true && Vars.ToastWaitTimeRemaining <= 0:
			CommonUtils.ToastNotifications.ElapsedTime = 0.0
			CommonUtils.ToastNotifications.IsWaiting = false
			Vars.ToastWaitTimeRemaining = Vars.ToastWaitTime
