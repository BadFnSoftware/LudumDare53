class_name MainMenuEvents
extends Node

var CreditsPanelNode: Node
var SoundPlayerNode: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	CreditsPanelNode = get_node("%CreditsPanel")
	SoundPlayerNode = get_node("%AudioStreamPlayer")

	Vars.Player = preload("res://Scripts/Resources/Player.gd").new()
	Vars.TickerData = preload("res://Scripts/Resources/Ticks.gd").new()

	Vars.TickerData.Tick = Vars.TICK_RATE

	Vars.UpdateJobFuncs = preload("res://Scripts/TickJobs/UpdateJobFuncs.gd").new()
	Vars.TickJobFuncs = preload("res://Scripts/TickJobs/TickJobFuncs.gd").new()
	Vars.MinuteJobFuncs = preload("res://Scripts/TickJobs/MinuteJobFuncs.gd").new()
	Vars.HourlyJobFuncs = preload("res://Scripts/TickJobs/HourlyJobFuncs.gd").new()
	Vars.DailyJobFuncs = preload("res://Scripts/TickJobs/DailyJobFuncs.gd").new()
	Vars.WeeklyJobFuncs = preload("res://Scripts/TickJobs/WeeklyJobFuncs.gd").new()
	Vars.MonthlyJobFuncs = preload("res://Scripts/TickJobs/MonthlyJobFuncs.gd").new()
	Vars.YearlyJobFuncs = preload("res://Scripts/TickJobs/YearlyJobFuncs.gd").new()


func _on_start_button_pressed():
	Vars.Player.AvailEnvelopes = CommonUtils.gatherAllEnvelopes()

	if !Vars.Player.AvailEnvelopes.is_empty():
		Vars.Player.NumEnvelopesAvail = Vars.Player.AvailEnvelopes.size()
		Vars.Player.NumTotalEnvelopes = Vars.Player.NumEnvelopesAvail
		Vars.Player.AvailCustomerModels = CommonUtils.gatherAllCustomerModels()
		Vars.Player.AvailCustomerDialogTrees = CommonUtils.gatherAllCustomerDialogTrees()

	get_tree().change_scene_to_file("res://Scenes/HowToPlay.tscn")


func _on_open_credits_pressed():
	SoundController.playSound("buttonpress1", SoundPlayerNode)
	CreditsPanelNode.visible = true


func _on_close_credits_pressed():
	SoundController.playSound("buttonpress1", SoundPlayerNode)
	CreditsPanelNode.visible = false
