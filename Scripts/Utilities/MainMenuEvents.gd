extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Vars.Player = preload("res://Scripts/Resources/Player.gd").new()
	Vars.TickerData = preload("res://Scripts/Resources/Ticks.gd").new()

	Vars.UpdateJobFuncs = preload("res://Scripts/TickJobs/UpdateJobFuncs.gd").new()
	Vars.TickJobFuncs = preload("res://Scripts/TickJobs/TickJobFuncs.gd").new()
	Vars.HourlyJobFuncs = preload("res://Scripts/TickJobs/HourlyJobFuncs.gd").new()
	Vars.DailyJobFuncs = preload("res://Scripts/TickJobs/DailyJobFuncs.gd").new()
	Vars.WeeklyJobFuncs = preload("res://Scripts/TickJobs/WeeklyJobFuncs.gd").new()
	Vars.MonthlyJobFuncs = preload("res://Scripts/TickJobs/MonthlyJobFuncs.gd").new()
	Vars.YearlyJobFuncs = preload("res://Scripts/TickJobs/YearlyJobFuncs.gd").new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	Vars.Player.AvailEnvelopes = CommonUtils.gatherAllEnvelopes()
	
	if !Vars.Player.AvailEnvelopes.is_empty():
		Vars.Player.NumEnvelopesAvail = Vars.Player.AvailEnvelopes.size()
		Vars.Player.NumTotalEnvelopes = Vars.Player.NumEnvelopesAvail
		Vars.Player.AvailCustomers = CommonUtils.gatherAllCustomerModels()

	get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")


func _on_settings_button_pressed():
	pass # Replace with function body.
