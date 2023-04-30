class_name CustomerEnvelopes
extends Resource

@export_group("Customer Details")
@export var FirstName: String
@export var LastName: String

@export_group("Configuration")
@export var RackSlotId: int
@export var IsPackage: bool
@export var IsDangerous: bool
@export var IsScanned := false
@export var Reported := false
@export var Contents: String
