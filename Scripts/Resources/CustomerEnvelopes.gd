class_name CustomerEnvelopes
extends Resource

@export_group("Customer Details")
@export var FirstName: String
@export var LastName: String
@export var Gender = Vars.GenderTypes.MALE

@export_group("Configuration")
@export var RackSlotId: int
@export var EnvelopeId: int
@export var IsPackage: bool
@export var IsDangerous: bool
@export_file var Contents
