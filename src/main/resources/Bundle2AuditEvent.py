import os
import json

class RuleBasedSystem:
    def __init__(self):
        self.rules = []

    def add_rule(self, condition, action):
        self.rules.append((condition, action))

    def apply_rules(self, data):
        for entry in data["entry"]:
            for condition, action in self.rules:
                if condition(entry):
                    action(entry, data)

def remove_empty_based_on(json_obj):
    if isinstance(json_obj, dict):
        for key, value in list(json_obj.items()):
            if isinstance(value, dict):
                # Check if the current dictionary has a "basedOn" key with an empty "reference"
                if key == "basedOn" and value.get("reference", "") == "":
                    del json_obj[key]
                else:
                    remove_empty_based_on(value)
            elif isinstance(value, list):
                for item in value:
                    remove_empty_based_on(item)
    elif isinstance(json_obj, list):
        for item in json_obj:
            remove_empty_based_on(item)
    return json_obj

def create_auditevent(id, recorded, careplan_reference, subject_reference, encounter_fullUrl, subject_display="", performer_reference="", performer_display="", code_system="", code_code="", code_display="", code_text=""):
    audit_event = {
        "fullUrl": id,
        "resource": {
            "resourceType": "AuditEvent",
            "id": id,
            "text": {"status": "generated"},
            "category": [{
                "coding": [{
                    "system": "http://hl7.org/fhir/restful-interaction",
                    "code": "transaction",
                    "display": "transaction"
                }]
            }],
            "code": {
                "coding": [{
                    "system": code_system,
                    "code": code_code,
                    "display": code_display
                }],
                "text": code_text
            },
            "action": "C",
            "occurredDateTime": recorded,
            "recorded": recorded,
            "outcome": {
                "code": {
                    "system": "http://terminology.hl7.org/CodeSystem/audit-event-outcome",
                    "code": "0",
                    "display": "Success"
                }
            },
            "basedOn": {"reference": careplan_reference},
            "patient": {"reference": subject_reference, "display": subject_display},
            "encounter": {"reference": encounter_fullUrl},
            "agent": [{"who": {"reference": performer_reference, "display": performer_display}}],
        },
        "request": {"method": "POST", "url": "AuditEvent"}
    }
    return audit_event

def encounter2auditevent(entry, data):
    encounter_fullUrl = entry["fullUrl"]
    id = entry["fullUrl"]
    subject_display = entry["resource"]["subject"]["display"]
    subject_reference = entry["resource"]["subject"]["reference"]
    performer_display = entry["resource"]["participant"][0]["individual"]["display"]
    performer_reference = entry["resource"]["participant"][0]["individual"]["reference"]
    recorded = entry["resource"]["period"]["start"]
    code_system = entry["resource"]["type"][0]["coding"][0]["system"]
    code_code = entry["resource"]["type"][0]["coding"][0]["code"]
    code_display = entry["resource"]["type"][0]["coding"][0]["display"]
    code_text = entry["resource"]["type"][0]["text"]
    careplan_reference = ""
    for subentry in data["entry"]:
        if subentry["resource"]["resourceType"] == "CarePlan" and subentry["resource"]["encounter"]["reference"] == encounter_fullUrl:
            careplan_reference = subentry["fullUrl"]
    return create_auditevent(id, recorded, careplan_reference, subject_reference, encounter_fullUrl, subject_display, performer_reference, performer_display, code_system, code_code, code_display, code_text)

def condition2auditevent(condition, data):
    id = condition["fullUrl"]
    encounter_fullUrl = condition["resource"]["encounter"]["reference"]
    subject_reference = condition["resource"]["subject"]["reference"]
    recorded = condition["resource"]["recordedDate"]
    code_system = condition["resource"]["code"]["coding"][0]["system"]
    code_code = condition["resource"]["code"]["coding"][0]["code"]
    code_display = condition["resource"]["code"]["coding"][0]["display"]
    code_text = condition["resource"]["code"]["text"]
    careplan_reference = ""
    for subentry in data["entry"]:
        if subentry["resource"]["resourceType"] == "CarePlan" and subentry["resource"]["encounter"]["reference"] == encounter_fullUrl:
            careplan_reference = subentry["fullUrl"]
        if subentry["resource"]["resourceType"] == "Encounter" and subentry["fullUrl"] == encounter_fullUrl:
            subject_display = subentry["resource"]["subject"]["display"]
            subject_reference = subentry["resource"]["subject"]["reference"]
            performer_display = subentry["resource"]["participant"][0]["individual"]["display"]
            performer_reference = subentry["resource"]["participant"][0]["individual"]["reference"]
    return create_auditevent(id, recorded, careplan_reference, subject_reference, encounter_fullUrl, subject_display, performer_reference, performer_display, code_system, code_code, code_display, code_text)

def procedure2auditevent(procedure, data):
    id = procedure["fullUrl"]
    encounter_fullUrl = procedure["resource"]["encounter"]["reference"]
    subject_reference = procedure["resource"]["subject"]["reference"]
    recorded = procedure["resource"]["performedPeriod"]["start"]
    code_system = procedure["resource"]["code"]["coding"][0]["system"]
    code_code = procedure["resource"]["code"]["coding"][0]["code"]
    code_display = procedure["resource"]["code"]["coding"][0]["display"]
    code_text = procedure["resource"]["code"]["text"]
    careplan_reference = ""
    for subentry in data["entry"]:
        if subentry["resource"]["resourceType"] == "CarePlan" and subentry["resource"]["encounter"]["reference"] == encounter_fullUrl:
            careplan_reference = subentry["resource"]["encounter"]["reference"]
        if subentry["resource"]["resourceType"] == "Encounter" and subentry["fullUrl"] == encounter_fullUrl:
            subject_display = subentry["resource"]["subject"]["display"]
            subject_reference = subentry["resource"]["subject"]["reference"]
            performer_display = subentry["resource"]["participant"][0]["individual"]["display"]
            performer_reference = subentry["resource"]["participant"][0]["individual"]["reference"]
    return create_auditevent(id, recorded, careplan_reference, subject_reference, encounter_fullUrl, subject_display, performer_reference, performer_display, code_system, code_code, code_display, code_text)

# Define functions for other resource types...

def observation2auditevent(observation, data):
    id = observation["fullUrl"]
    encounter_fullUrl = observation["resource"]["encounter"]["reference"]
    subject_reference = observation["resource"]["subject"]["reference"]
    recorded = observation["resource"]["issued"]
    code_system = observation["resource"]["code"]["coding"][0]["system"]
    code_code = observation["resource"]["code"]["coding"][0]["code"]
    code_display = observation["resource"]["code"]["coding"][0]["display"]
    code_text = observation["resource"]["code"]["text"]
    careplan_reference = ""
    for subentry in data["entry"]:
        if subentry["resource"]["resourceType"] == "CarePlan" and subentry["resource"]["encounter"]["reference"] == encounter_fullUrl:
            careplan_reference = subentry["resource"]["encounter"]["reference"]
        if subentry["resource"]["resourceType"] == "Encounter" and subentry["fullUrl"] == encounter_fullUrl:
            subject_display = subentry["resource"]["subject"]["display"]
            subject_reference = subentry["resource"]["subject"]["reference"]
            performer_display = subentry["resource"]["participant"][0]["individual"]["display"]
            performer_reference = subentry["resource"]["participant"][0]["individual"]["reference"]
    return create_auditevent(id, recorded, careplan_reference, subject_reference, encounter_fullUrl, subject_display, performer_reference, performer_display, code_system, code_code, code_display, code_text)

def diagnosticreport2auditevent(diagnosticreport, data):
    id = diagnosticreport["fullUrl"]
    encounter_fullUrl = diagnosticreport["resource"]["encounter"]["reference"]
    recorded = diagnosticreport["resource"]["issued"]
    code_system = diagnosticreport["resource"]["code"]["coding"][0]["system"]
    code_code = diagnosticreport["resource"]["code"]["coding"][0]["code"]
    code_display = diagnosticreport["resource"]["code"]["coding"][0]["display"]
    code_text = diagnosticreport["resource"]["code"]["text"]
    careplan_reference = ""
    for subentry in data["entry"]:
        if subentry["resource"]["resourceType"] == "CarePlan" and subentry["resource"]["encounter"]["reference"] == encounter_fullUrl:
            careplan_reference = subentry["resource"]["encounter"]["reference"]
        if subentry["resource"]["resourceType"] == "Encounter" and subentry["fullUrl"] == encounter_fullUrl:
            subject_display = subentry["resource"]["subject"]["display"]
            subject_reference = subentry["resource"]["subject"]["reference"]
            performer_display = subentry["resource"]["participant"][0]["individual"]["display"]
            performer_reference = subentry["resource"]["participant"][0]["individual"]["reference"]
    return create_auditevent(id, recorded, careplan_reference, subject_reference, encounter_fullUrl, subject_display, performer_reference, performer_display, code_system, code_code, code_display, code_text)

def medicationrequest2auditevent(medicationrequest, data):
    id = medicationrequest["fullUrl"]
    encounter_fullUrl = medicationrequest["resource"]["encounter"]["reference"]
    subject_reference = medicationrequest["resource"]["subject"]["reference"]
    recorded = medicationrequest["resource"]["authoredOn"]
    code_system = medicationrequest["resource"]["medicationCodeableConcept"]["coding"][0]["system"]
    code_code = medicationrequest["resource"]["medicationCodeableConcept"]["coding"][0]["code"]
    code_display = medicationrequest["resource"]["medicationCodeableConcept"]["coding"][0]["display"]
    code_text = medicationrequest["resource"]["medicationCodeableConcept"]["text"]
    careplan_reference = ""
    for subentry in data["entry"]:
        if subentry["resource"]["resourceType"] == "CarePlan" and subentry["resource"]["encounter"]["reference"] == encounter_fullUrl:
            careplan_reference = subentry["resource"]["encounter"]["reference"]
        if subentry["resource"]["resourceType"] == "Encounter" and subentry["fullUrl"] == encounter_fullUrl:
            subject_display = subentry["resource"]["subject"]["display"]
            subject_reference = subentry["resource"]["subject"]["reference"]
            performer_display = subentry["resource"]["participant"][0]["individual"]["display"]
            performer_reference = subentry["resource"]["participant"][0]["individual"]["reference"]
    return create_auditevent(id, recorded, careplan_reference, subject_reference, encounter_fullUrl, subject_display, performer_reference, performer_display, code_system, code_code, code_display, code_text)

# Define conditions
def is_encounter(entry):
    return entry["resource"]["resourceType"] == "Encounter"

def is_condition(entry):
    return entry["resource"]["resourceType"] == "Condition"

def is_procedure(entry):
    return entry["resource"]["resourceType"] == "Procedure"

def is_observation(entry):
    return entry["resource"]["resourceType"] == "Observation"

def is_diagnosticreport(entry):
    return entry["resource"]["resourceType"] == "Diagnosticreport"

def is_medicationrequest(entry):
    return entry["resource"]["resourceType"] == "Medicationreques"

# Add more conditions for other resource types...

# Define actions
def process_encounter(entry, data):
    data["entry"].append(encounter2auditevent(entry, data))

def process_condition(entry, data):
    data["entry"].append(condition2auditevent(entry, data))

def process_procedure(entry, data):
    data["entry"].append(procedure2auditevent(entry, data))

def process_observation(entry, data):
    data["entry"].append(observation2auditevent(entry, data))

def process_diagnosticreport(entry, data):
    data["entry"].append(diagnosticreport2auditevent(entry, data))

def process_medicationrequest(entry, data):
    data["entry"].append(medicationrequest2auditevent(entry, data))


# Add more actions for other resource types...

# Create rule-based system
system = RuleBasedSystem()
system.add_rule(is_encounter, process_encounter)
system.add_rule(is_condition, process_condition)
system.add_rule(is_procedure, process_procedure)
system.add_rule(is_observation, process_observation)
system.add_rule(is_diagnosticreport, process_procedure)
system.add_rule(is_medicationrequest, process_medicationrequest)
# Add more rules for other resource types...

# Apply rules to data
directory_path = "output/fhir"
for filename in os.listdir(directory_path):
    if filename.endswith(".json"):
        file_path = os.path.join(directory_path, filename)
        try:
            with open(file_path, "r") as file:
                data = json.load(file)
            if not any(entry["resource"]["resourceType"] == "AuditEvent" for entry in data["entry"]):
                system.apply_rules(data)
                remove_empty_based_on(data)
                with open(file_path, "w") as file:
                    json.dump(data, file, indent=4)
        except Exception as e:
            print(f"An error occurred for filename: {filename}\nError: {e}")

print("Done")
