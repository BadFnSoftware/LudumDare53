class_name CustomerDialogTree
extends Resource

@export_group("Customer Initial Greeting")
@export_multiline var CustomerGreetingDialog: String

@export_group("Initial Customer Response")
@export_multiline var GreetingBestResponse: String
@export_multiline var GreetingGoodResponse: String
@export_multiline var GreetingBadResponse: String
@export_multiline var GreetingWorstResponse: String

@export_group("Customer Demand")
@export_multiline var CustomerDemandDialog: String

@export_group("Demand Response")
@export_multiline var DemandBestResponse: String
@export_multiline var DemandGoodResponse: String
@export_multiline var DemandBadResponse: String
@export_multiline var DemandWorstResponse: String
