class_name Player
extends Resource

@export var CurrentEnvelope: CustomerEnvelopes
@export var CurrentCustomerModel: Resource
@export var CurrentCustomerDialogTree: Resource
@export var CustomerGreetingResponseGrade: String
@export var CustomerDemandResponseGrade: String
@export var NumEnvelopesSorted := 0
@export var NumPackagesSorted := 0
@export var NumDangerousPackagesSorted := 0
@export var NumDangerousPackageMistakes := 0
@export var NumMistakes := 0
@export var NumPackagesReported := 0
@export var NumPackagesReportedMistakes := 0
@export var NumAngryCustomers := 0
@export var NumContentCustomers := 0
@export var NumHappyCustomers := 0
@export var CustomerComplaintList := []
@export var AngryCustomerList := []
@export var ContentCustomerList := []
@export var HappyCustomerList := []
@export var AvailCustomerModels := []
@export var AvailCustomerDialogTrees := []
@export var AvailEnvelopes := []
@export var NumEnvelopesAvail: int
@export var NumTotalEnvelopes: int
