Alias: $us-core-race = http://hl7.org/fhir/us/core/StructureDefinition/us-core-race
Alias: $us-core-ethnicity = http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity
Alias: $us-core-tribal-affiliation = http://hl7.org/fhir/us/core/StructureDefinition/us-core-tribal-affiliation
Alias: $us-core-birthsex = http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex
Alias: $us-core-sex = http://hl7.org/fhir/us/core/StructureDefinition/us-core-sex
Alias: $us-core-genderIdentity = http://hl7.org/fhir/us/core/StructureDefinition/us-core-genderIdentity
Alias: $administrative-gender = http://hl7.org/fhir/ValueSet/administrative-gender
Alias: $us-core-usps-state = http://hl7.org/fhir/us/core/ValueSet/us-core-usps-state
Alias: $simple-language = http://hl7.org/fhir/us/core/ValueSet/simple-language

Profile: USCorePatientProfile
Parent: Patient
Id: us-core-patient
Title: "US Core Patient Profile"
Description: "The US Core Patient Profile meets the U.S. Core Data for Interoperability (USCDI) v3 'Patient Demographics' requirements. This profile sets minimum expectations for the Patient resource to record, search, and fetch basic demographics and other administrative information about an individual patient. It identifies which core elements, extensions, vocabularies, and value sets **SHALL** be present in the resource when using this profile to promote interoperability and adoption through common implementation.  It identifies which core elements, extensions, vocabularies, and value sets **SHALL** be present in the resource and constrains the way the elements are used when using this profile.  It provides the floor for standards development for specific use cases."
* ^version = "6.1.0"
* ^experimental = false
* ^date = "2022-09-30"
* ^publisher = "HL7 International - Cross-Group Projects"
* ^contact.name = "HL7 International - Cross-Group Projects"
* ^contact.telecom[0].system = #url
* ^contact.telecom[=].value = "http://www.hl7.org/Special/committees/cgp"
* ^contact.telecom[+].system = #email
* ^contact.telecom[=].value = "cgp@lists.HL7.org"
* ^jurisdiction = urn:iso:std:iso:3166#US
* ^copyright = "Used by permission of HL7 International, all rights reserved Creative Commons License"
* . ^definition = "\\-"
* . ^comment = "\\-"
* . ^mustSupport = false
* extension contains
    $us-core-race named race 0..1 and
    $us-core-ethnicity named ethnicity 0..1 and
    $us-core-tribal-affiliation named tribalAffiliation 0..* and
    $us-core-birthsex named birthsex 0..1 and
    $us-core-sex named sex 0..1 and
    $us-core-genderIdentity named genderIdentity 0..*
* extension[race] ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* extension[race] ^extension.valueBoolean = true
* extension[race] ^short = "(USCDI) US Core Race Extension"
* extension[race] ^mustSupport = false
* extension[ethnicity] ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* extension[ethnicity] ^extension.valueBoolean = true
* extension[ethnicity] ^short = "(USCDI) US Core ethnicity Extension"
* extension[ethnicity] ^mustSupport = false
* extension[tribalAffiliation] ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* extension[tribalAffiliation] ^extension.valueBoolean = true
* extension[tribalAffiliation] ^short = "(USCDI) Tribal Affiliation Extension"
* extension[tribalAffiliation] ^mustSupport = false
* extension[birthsex] ^short = "Birth Sex Extension"
* extension[birthsex] ^mustSupport = false
* extension[sex] ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* extension[sex] ^extension.valueBoolean = true
* extension[sex] ^short = "(USCDI) Sex Extension"
* extension[sex] ^mustSupport = false
* extension[genderIdentity] ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* extension[genderIdentity] ^extension.valueBoolean = true
* extension[genderIdentity] ^short = "(USCDI) The individual's gender identity"
* extension[genderIdentity] ^mustSupport = false
* identifier 1.. MS
* identifier ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* identifier ^extension.valueBoolean = true
* identifier ^short = "(USCDI) An identifier for this patient"
* identifier.system 1.. MS
* identifier.system ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* identifier.system ^extension.valueBoolean = true
* identifier.system ^short = "(USCDI) The namespace for the identifier value"
* identifier.value 1.. MS
* identifier.value ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* identifier.value ^extension.valueBoolean = true
* identifier.value ^short = "(USCDI) The value that is unique within the system."
* name 1.. MS
* name obeys us-core-6
* name ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* name ^extension.valueBoolean = true
* name ^short = "(USCDI) A name associated with the patient"
* name.use ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* name.use ^extension.valueBoolean = true
* name.use ^short = "(USCDI) usual | official | temp | nickname | anonymous | old | maiden"
* name.family MS
* name.family ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* name.family ^extension.valueBoolean = true
* name.family ^short = "(USCDI) Family name (often called 'Surname')"
* name.family ^condition = "us-core-6"
* name.given MS
* name.given ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* name.given ^extension.valueBoolean = true
* name.given ^short = "(USCDI) Given names (not always 'first'). Includes middle names"
* name.given ^condition = "us-core-6"
* name.suffix ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* name.suffix ^extension.valueBoolean = true
* name.suffix ^short = "(USCDI) Parts that come after the name"
* name.suffix ^mustSupport = false
* name.period ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* name.period ^extension.valueBoolean = true
* name.period ^short = "(USCDI) Time period when name was/is in use"
* name.period ^mustSupport = false
* telecom ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* telecom ^extension.valueBoolean = true
* telecom ^short = "(USCDI) A contact detail for the individual"
* telecom ^mustSupport = false
* telecom.system 1.. MS
* telecom.system from ContactPointSystem (required)
* telecom.system ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* telecom.system ^extension.valueBoolean = true
* telecom.system ^short = "(USCDI) phone | fax | email | pager | url | sms | other"
* telecom.system ^binding.description = "Telecommunications form for contact point."
* telecom.value 1.. MS
* telecom.value ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* telecom.value ^extension.valueBoolean = true
* telecom.value ^short = "(USCDI) The actual contact point details"
* telecom.use MS
* telecom.use from ContactPointUse (required)
* telecom.use ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* telecom.use ^extension.valueBoolean = true
* telecom.use ^short = "(USCDI) home | work | temp | old | mobile - purpose of this contact point"
* gender 1.. MS
* gender only code
* gender from $administrative-gender (required)
* gender ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* gender ^extension.valueBoolean = true
* gender ^short = "(USCDI) male | female | other | unknown"
* birthDate MS
* birthDate ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* birthDate ^extension.valueBoolean = true
* birthDate ^short = "(USCDI) The date of birth for the individual"
* deceased[x] ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* deceased[x] ^extension.valueBoolean = true
* deceased[x] ^short = "(USCDI) Indicates if the individual is deceased or not"
* address MS
* address ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* address ^extension.valueBoolean = true
* address ^short = "(USCDI) An address for the individual"
* address.use ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* address.use ^extension.valueBoolean = true
* address.use ^short = "(USCDI) home | work | temp | old | billing - purpose of this address"
* address.line MS
* address.line ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* address.line ^extension.valueBoolean = true
* address.line ^short = "(USCDI) Street name, number, direction & P.O. Box etc."
* address.city MS
* address.city ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* address.city ^extension.valueBoolean = true
* address.city ^short = "(USCDI) Name of city, town etc."
* address.state MS
* address.state from $us-core-usps-state (extensible)
* address.state ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* address.state ^extension.valueBoolean = true
* address.state ^short = "(USCDI) Sub-unit of country (abbreviations ok)"
* address.state ^binding.description = "Two Letter USPS alphabetic codes."
* address.postalCode MS
* address.postalCode ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* address.postalCode ^extension.valueBoolean = true
* address.postalCode ^short = "(USCDI) US Zip Codes"
* address.postalCode ^alias = "Zip Code"
* address.period ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* address.period ^extension.valueBoolean = true
* address.period ^short = "(USCDI) Time period when address was/is in use"
* communication ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* communication ^extension.valueBoolean = true
* communication ^short = "(USCDI) A language which may be used to communicate with the patient about his or her health"
* communication ^mustSupport = false
* communication.language MS
* communication.language from $simple-language (extensible)
* communication.language ^extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/uscdi-requirement"
* communication.language ^extension.valueBoolean = true
* communication.language ^short = "(USCDI) The language which can be used to communicate with the patient about his or her health"

Invariant: us-core-6
Description: "At least name.given and/or name.family are present or, if neither is available, the Data Absent Reason Extension is present."
* severity = #error
* expression = "(family.exists() or given.exists()) xor extension.where(url='http://hl7.org/fhir/StructureDefinition/data-absent-reason').exists()"
* xpath = "(/f:extension/@url='http://hl7.org/fhir/StructureDefinition/data-absent-reason' and not(/f:family or /f:given)) or (not(/f:extension/@url='http://hl7.org/fhir/StructureDefinition/data-absent-reason') and (/f:family or /f:given))"

// WARNING: The following Mapping may be incomplete since the original USCorePatientProfile
// StructureDefinition was missing the mapping entry for argonaut-dq-dstu2.
// Please review this and add the following properties as necessary: Target, Title, Description
Mapping: argonaut-dq-dstu2
Id: argonaut-dq-dstu2
Source: USCorePatientProfile
* -> "Patient"
* extension[race] -> "Patient.extension"
* extension[ethnicity] -> "Patient.extension"
* extension[birthsex] -> "Patient.extension"
* identifier -> "Patient.identifier"
* identifier.system -> "Patient.identifier.system"
* identifier.value -> "Patient.identifier.value"
* name -> "Patient.name"
* name.family -> "Patient.name.family"
* name.given -> "Patient.name.given"
* name.suffix -> "NA"
* name.period -> "NA"
* telecom -> "NA"
* telecom.system -> "NA"
* telecom.value -> "NA"
* telecom.use -> "NA"
* gender -> "Patient.gender"
* birthDate -> "Patient.birthDate"
* address -> "Patient.birthDate"
* address.line -> "NA"
* address.city -> "NA"
* address.state -> "NA"
* address.postalCode -> "NA"
* address.period -> "NA"
* communication -> "Patient.communication"
* communication.language -> "Patient.communication.language"