extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Vars.EndGameNumEnvelopesSortedNode = get_node("%NumEnvelopesSorted")
	Vars.EndGameNumPackagesSortedNode = get_node("%NumPackagesSorted")
	Vars.EndGameNumSortingMistakesNode = get_node("%NumSortingMistakes")
	Vars.EndGameNumDangerousPackagesSortedNode = get_node("%NumDangerousPackagesSorted")
	Vars.EndGameNumDangerousPackageSortingMistakesNode = get_node("%NumDangerousPackageSortingMistakes")
	Vars.EndGameNumNotSortedNode = get_node("%NumNotSorted")
	Vars.EndGameNumPackagesReportedNode = get_node("%NumPackagesReported")
	Vars.EndGameNumPackagesReportedMistakesNode = get_node("%NumPackagesReportedMistakes")
	Vars.EndGameNumHappyCustomersNode = get_node("%NumHappyCustomers")
	Vars.EndGameNumContentCustomersNode = get_node("%NumContentCustomers")
	Vars.EndGameNumAngryCustomersNode = get_node("%NumAngryCustomers")
	Vars.EndGameOverallGradeNode = get_node("%OverallGrade")
	Vars.EndGameYourFiredTextNode = get_node("%YourFiredText")

	if Vars.Player.NumHappyCustomers == Vars.Player.NumTotalEnvelopes && Vars.Player.NumContentCustomers == 0 && Vars.Player.NumAngryCustomers == 0 && Vars.Player.NumMistakes == 0 && Vars.Player.NumDangerousPackageMistakes == 0:
		Vars.EndGameOverallGrade = "A"
	elif Vars.Player.NumHappyCustomers > 0 && Vars.Player.NumContentCustomers >= 0 && Vars.Player.NumAngryCustomers == 0 && (Vars.Player.NumMistakes > 0 && Vars.Player.NumMistakes <= 2) && Vars.Player.NumDangerousPackageMistakes == 0:
		Vars.EndGameOverallGrade = "B"
	elif Vars.Player.NumHappyCustomers > 0 && Vars.Player.NumContentCustomers >= 0 && Vars.Player.NumAngryCustomers >= 0 && (Vars.Player.NumMistakes > 0 && Vars.Player.NumMistakes < Vars.Player.NumTotalEnvelopes) && Vars.Player.NumDangerousPackageMistakes == 0:
		Vars.EndGameOverallGrade = "C"
	elif Vars.Player.NumHappyCustomers == 0 && Vars.Player.NumContentCustomers >= 0 && Vars.Player.NumAngryCustomers >= 0 && Vars.Player.NumMistakes > 0 && Vars.Player.NumDangerousPackageMistakes == 0:
		Vars.EndGameOverallGrade = "D"
		Vars.EndGameIsFired = true
	elif (Vars.Player.NumHappyCustomers == 0 && Vars.Player.NumContentCustomers == 0 && Vars.Player.NumAngryCustomers == Vars.Player.NumTotalEnvelopes) || Vars.Player.NumDangerousPackageMistakes > 0:
		Vars.EndGameOverallGrade = "F"
		Vars.EndGameIsFired = true
	
	CommonUtils.setEndGameDisplay()


func _on_end_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
