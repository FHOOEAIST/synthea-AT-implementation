# Extending Synthea to Generate FHIR AuditEvent Resources for the PICA Project

## Overview

 For the PICA project, there is a need to extend Synthea to generate the FHIR AuditEvent resource. The FHIR AuditEvent resource serves as a structured representation of auditable events within a healthcare system, crucial for reconstructing processes from various perspectives, particularly within a patient-centric view.

## Purpose of the FHIR AuditEvent Resource in PICA

The FHIR AuditEvent resource within the context of the PICA project supports multiple perspectives essential for analyzing and reconstructing healthcare processes:

1. **Core Perspective**: Attributes such as `ae.patient` and `ae.occurredDateTime` provide essential details to reconstruct processes, containing the minimum information required for this purpose.

2. **Conformance Perspective**: Tasks conducted are documented with machine-readable codes within the AuditEvents using the `ae.code` attribute, which refer to a standardized log of operational events.

3. **Patient-Visit Perspective**: AuditEvents reference an Encounter resource using the `ae.encounter` attribute, grouping multiple events related to a patient visit. This enables the analysis of patient pathways during encounters, such as hospital stays.

4. **Care-Pathway Perspective**: AuditEvents document pathways followed by patients, such as defined or recorded CarePlans using the `ae.basedOn` attribute. This allows for the analysis of specific processes followed by patients.

5. **Actor Perspective**: Agents participating in process steps are identified within AuditEvents, allowing for the analysis of processes from multiple perspectives.

## Implementation Strategy

To achieve the generation of the FHIR AuditEvent resource, we need to extend Synthea's post-processing capabilities. This involves the creation of custom scripts that process the generated FHIR bundles and create corresponding AuditEvent resources.

### Steps to Implement

1. **Define the AuditEvent Structure**: Identify and define the necessary attributes for the AuditEvent resource, such as `ae.patient`, `ae.occurredDateTime`, `ae.code`, `ae.encounter`, `ae.basedOn`, and the actor information.

2. **Modify Synthea's Post-Processing**: Create scripts to post-process the generated FHIR bundles from Synthea. These scripts will:
   - Extract relevant information from existing resources (e.g., Patient, Encounter, CarePlan,Procedures,Observations, ...).
   - Generate new AuditEvent resources based on the extracted data.
   - Link AuditEvent resources to other resources within the bundle.

3. **Integration**: Integrate the scripts into the Synthea workflow.

## Relationships Between FHIR Resources in the PICA Project

The following diagram illustrates the relationships between various FHIR resources within the context of the PICA project. These resources are interconnected to provide a comprehensive representation of auditable events, patient care, and clinical data.

![resource-relationships](./img/AuditEvent%20relationship.png)


## Key Resources and Their Relationships

### AuditEvent
The `AuditEvent` resource captures auditable events within the healthcare system. It references multiple other resources to provide a detailed log of activities and their context. Key attributes include:
- **FullUrl**: Unique identifier for the AuditEvent.
- **resourceType**: Specifies the type of resource (AuditEvent).
- **code**: Machine-readable code documenting the type of event.
- **occurredDateTime**: Timestamp of when the event occurred.
- **recorded**: Timestamp of when the event was recorded.
- **patient**: Reference to the `Patient` resource.
- **encounter**: Reference to the `Encounter` resource.
- **basedOn**: Reference to the `CarePlan` resource.
- **agent**: Information about the agent involved in the event.

### Patient
The `Patient` resource represents individual patients. Key attributes include:
- **FullUrl**: Unique identifier for the Patient.
- **resourceType**: Specifies the type of resource (Patient).

### Encounter
The `Encounter` resource represents an interaction between a patient and healthcare provider(s). It groups multiple events related to a patient visit. Key attributes include:
- **FullUrl**: Unique identifier for the Encounter.
- **resourceType**: Specifies the type of resource (Encounter).
- **basedOn**: Reference to the `CarePlan` resource.
- **subject**: Reference to the `Patient` resource.
- **participant**: Participants involved in the encounter.

### CarePlan
The `CarePlan` resource outlines the management plan for a patient's healthcare. Key attributes include:
- **FullUrl**: Unique identifier for the CarePlan.

### Observation
The `Observation` resource captures measurements and assertions about a patient's health. Key attributes include:
- **FullUrl**: Unique identifier for the Observation.
- **resourceType**: Specifies the type of resource (Observation).
- **code**: Code representing the type of observation.
- **issued**: Timestamp when the observation was made.
- **subject**: Reference to the `Patient` resource.
- **encounter**: Reference to the `Encounter` resource.

### DiagnosticReport
The `DiagnosticReport` resource represents the findings and interpretation of diagnostic tests. Key attributes include:
- **FullUrl**: Unique identifier for the DiagnosticReport.
- **resourceType**: Specifies the type of resource (DiagnosticReport).
- **code**: Code representing the type of diagnostic report.
- **issued**: Timestamp when the report was issued.
- **subject**: Reference to the `Patient` resource.
- **encounter**: Reference to the `Encounter` resource.

### MedicationRequest
The `MedicationRequest` resource documents a request for medication for a patient. Key attributes include:
- **FullUrl**: Unique identifier for the MedicationRequest.
- **resourceType**: Specifies the type of resource (MedicationRequest).
- **medicationCodeableConcept**: Code representing the medication.
- **authoredOn**: Timestamp when the request was made.
- **subject**: Reference to the `Patient` resource.
- **encounter**: Reference to the `Encounter` resource.

### Condition
The `Condition` resource represents the clinical conditions or diagnoses of a patient. Key attributes include:
- **FullUrl**: Unique identifier for the Condition.
- **resourceType**: Specifies the type of resource (Condition).
- **code**: Code representing the condition.
- **recordedDate**: Timestamp when the condition was recorded.
- **subject**: Reference to the `Patient` resource.
- **encounter**: Reference to the `Encounter` resource.

### Procedure
The `Procedure` resource documents actions performed on a patient. Key attributes include:
- **FullUrl**: Unique identifier for the Procedure.
- **resourceType**: Specifies the type of resource (Procedure).
- **code**: Code representing the procedure.
- **subject**: Reference to the `Patient` resource.
- **encounter**: Reference to the `Encounter` resource.
- **period**: Time period during which the procedure was performed.

## Summary of Relationships

- **AuditEvent** references:
  - `Patient` (via `patient` attribute)
  - `Encounter` (via `encounter` attribute)
  - `CarePlan` (via `basedOn` attribute)
- **Encounter** references:
  - `Patient` (via `subject` attribute)
  - `CarePlan` (via `basedOn` attribute)
- **Observation, DiagnosticReport, MedicationRequest, Condition, Procedure** reference:
  - `Patient` (via `subject` attribute)
  - `Encounter` (via `encounter` attribute)

These relationships ensure a structured and comprehensive representation of healthcare events, facilitating detailed audits and analyses of patient care pathways and clinical processes within the PICA project.

# Implementing a Rule-Based System for FHIR AuditEvent Generation

Rule-based systems are a fundamental technology in the field of artificial intelligence (AI) and computer science. They are designed to solve problems by applying specific, predefined rules to input data to produce outputs. These systems are widely used in various domains, including expert systems, decision support systems, and natural language processing, among others.

## 1. Explicit Rules and Decision Logic

At its core, a rule-based system operates based on a set of explicitly defined rules. These rules determine how input data is processed to produce the desired output. In this script, the rules are implemented through various functions and conditional statements.

**Example: Rule for Encounter Resource**

The rule for processing an `Encounter` resource involves extracting the recorded date from `resource["period"]["start"]`. Each resource type has its own specific rules for extracting relevant fields.

## 2. Conditional Logic and Flow Control

The script uses conditional logic extensively to control the flow of data processing. These conditionals determine which rules to apply based on the type and attributes of the input data.

**Example: Extracting References**

The function for extracting references applies different conditions to extract references from `data["entry"]` based on the resource type and its relationships, guiding how the data should be processed.

## 3. Pattern Matching

Pattern matching involves identifying specific structures or sequences in the data to apply the corresponding rules. The script matches resource types and their attributes to determine how to process each entry.

**Example: Matching Resource Types**

A loop identifies the type of each resource and then calls a processing function with the appropriate parameters. This processing function contains the rules for handling each type of resource.

## 4. Data Transformation

The primary function of this script is to transform FHIR JSON resources into `AuditEvent` resources. Each transformation follows specific rules that are determined by the type and attributes of the input data.

**Example: Creating AuditEvent**

The function constructs an `AuditEvent` resource based on the provided parameters, which are populated according to the rules defined in other parts of the script.

## 5. Deterministic Behavior

A hallmark of rule-based systems is their deterministic nature. Given the same input, the system will always produce the same output, as it strictly follows the predefined rules without any learning or adaptation.

### Why

- **Predictable and Repeatable**: The behavior  is predictable and repeatable due to the explicit rules.
- **Non-Adaptive**: The script does not learn from data or adapt its behavior based on new inputs.
- **Complexity Managed by Rules**: The complexity of processing different types of FHIR resources is managed by the set of rules encoded in the functions.


## Other approaches

Other approaches can be found here [link](seq2seq_and_llm.md).
Here are other approaches that were expiremented with such as seq2seq models and large language models, however these did not yield the results expected for the creation of the FHIR AuditEvent resource

## Conclusion

By extending Synthea to generate FHIR AuditEvent resources, the PICA project can effectively document and analyze healthcare processes from various perspectives. This enhancement ensures that the synthetic data generated is not only comprehensive but also aligned with the audit and conformance requirements of healthcare systems.

while this approach does not involve machine learning or statistical models, it fits the broader category of rule-based systems that are an essential component of the AI domain, especially for tasks that require deterministic data processing and transformation based on predefined criteria.

This rule-based approach ensures that the FHIR AuditEvent resources are generated consistently and accurately, supporting the various perspectives required by the PICA project to reconstruct and analyze patient-centric processes.

