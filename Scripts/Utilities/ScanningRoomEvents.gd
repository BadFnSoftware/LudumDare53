extends Node2D

var Package: Node
var PackageStartingPosition: Vector2
var ScannerDestination: Node
var ScannerOffOverlayNode: Node
var ScannerOnOverlayNode: Node
var PackageContentsNode: Node

var EndScreenDestination: Node
var PackageDestination: Vector2
var ElapsedTime := 0.0
var XrayElapsedTime := 0.0

var PackageReachedScanner := false
var HasScanned := false

var PackageContentTexture: Resource
var SoundPlayerNode: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	SoundPlayerNode = get_node("%AudioStreamPlayer")
	SoundController.startSoundLoop("xraybelt", SoundPlayerNode)

	CommonUtils.ToastNotifications = preload("res://Scripts/Utilities/ToastNotifications.gd").new()
	CommonUtils.ToastNotifications.ToastNotifcationNode = get_node("%ToastNotificationBackground")
	CommonUtils.ToastNotifications.ToastNotifcationTextNode = get_node("%ToastNotificationText")

	CommonUtils.ToastNotifications.ErrorToastNotifcationNode = get_node("%ErrorToastNotificationBackground")
	CommonUtils.ToastNotifications.ErrorToastNotifcationTextNode = get_node("%ErrorToastNotificationText")

	CommonUtils.ToastNotifications.ToastNotifcationDestinationNode = get_node("%ToastNotificationDestination")

	CommonUtils.ToastNotifications.ToastNotifcationStartingPosition = CommonUtils.ToastNotifications.ToastNotifcationNode.get_position()
	CommonUtils.ToastNotifications.ToastNotifcationDestination = Vector2(CommonUtils.ToastNotifications.ToastNotifcationStartingPosition.x, CommonUtils.ToastNotifications.ToastNotifcationDestinationNode.get_position().y)

	Package = get_node("%Package")
	ScannerDestination = get_node("%ScannerDestination")
	EndScreenDestination = get_node("%EndScreenDestination")
	ScannerOffOverlayNode = get_node("%ScannerOffOverlay")
	ScannerOnOverlayNode = get_node("%ScannerOnOverlay")
	PackageContentsNode = get_node("%PackageContents")

	PackageStartingPosition = Package.get_position()
	PackageDestination = Vector2(ScannerDestination.get_position().x, PackageStartingPosition.y)

	PackageContentTexture = load("res://Assets/Objects/" + Vars.Player.CurrentEnvelope.Contents)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ElapsedTime += delta

	if Package.get_position().x > PackageDestination.x:
		Package.position = PackageStartingPosition.lerp(PackageDestination, ElapsedTime)
	else:
		if PackageReachedScanner == false:
			SoundController.playSound("xrayloop", SoundPlayerNode)

			PackageReachedScanner = true
			ScannerOffOverlayNode.visible = false
			ScannerOnOverlayNode.visible = true
			PackageContentsNode.texture = PackageContentTexture
			PackageContentsNode.visible = true

		if HasScanned == true:
			SoundController.startSoundLoop("xraybelt", SoundPlayerNode)

			PackageReachedScanner = true
			ElapsedTime = 0.0
			HasScanned = false
			PackageContentsNode.visible = false
			Vars.XrayWaitTimeRemaining = Vars.XrayWaitTime
			get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")

		if Vars.XrayWaitTimeRemaining > 0 && Vars.XrayWaitTimeRemaining <= Vars.XrayWaitTime && HasScanned == false:
			Vars.XrayWaitTimeRemaining -= delta
		elif Vars.XrayWaitTimeRemaining <= 0 && HasScanned == false:
			ElapsedTime = 0.0
			HasScanned = true
			PackageStartingPosition = Package.get_position()
			PackageDestination = Vector2(EndScreenDestination.get_position().x, PackageStartingPosition.y)
			ScannerOffOverlayNode.visible = true
			ScannerOnOverlayNode.visible = false
			PackageContentsNode.visible = false
