# Synthea<sup>TM</sup> Patient Generator with AT Core Profile Implementation ![Build Status](https://github.com/synthetichealth/synthea/workflows/.github/workflows/ci-build-test.yml/badge.svg?branch=master) [![codecov](https://codecov.io/gh/synthetichealth/synthea/branch/master/graph/badge.svg)](https://codecov.io/gh/synthetichealth/synthea)


The main goal of this research is to expand the capabilities of existing synthetic patient data generation. Aiming to enable them to generate the HL7 FHIR Austria patient profile effectively. Additionally, exploring the feasibility of supporting the generation of the AuditEvent FHIR resource. These enhancements will allow fort he creation of synthetic health data that aligns with local healthcare standards and captures patient clinical histories and pathways accurately.

In the process of reconstructing health data, currently utilizing Synthea-generated FHIR resources. However, these resources do not cover all the necessary information required for a comprehensive reconstruction. Therefore, there is a need to develop custom extensions to these generated FHIR resources. This will ensure that all required information is captured and used effectively.  

This repository is a fork of the Synthea<sup>TM</sup> Patient Generator, enhanced for the implementation of the AT Core Profile with its extensions and demographic data. It also includes the generation of the AuditEvent FHIR resource for process mining purposes in the PICA project and specific modules for local implementation of medical processes.


#### PICA - Process Intelligence and Conformance Auditing.

The project is concerned with the development and establishment of a process analytics connection for medical information systems, which can be used to create a “digital twin” of organizational processes. The development is based on internationally established communication standards in healthcare and in coordination with the Austrian affiliate organization HL7 Austria. Among other things, this will result in a publicly available implementation guideline that will be further developed on an ongoing basis. The implementation guide can be found at [AIST PICA Implementation Guide](https://fhir.hl7.at/r5-pica-5-deployment/index.html).

Within the PICA project, there is a need for generating synthetic and realistic patient data. These generated data sets must adhere strictly to the FHIR specification and encompass all the requisite resources to create both a FHIR Patient resource and FHIR AuditEvent resources or flexibility should be built in to enable adaptation for generating FHIR resources as needed

Moreover, the patient generated data must support the modelling of patient care plans and be adaptable to accommodate custom profiles tailored to specific regional requirements or unique use cases. This customization ensures that the generated patient data aligns closely with local healthcare practices. to accommodate the specific requirements and nuances of local healthcare contexts, such as those encountered in Austria. 

In the process of reconstructing health data, currently utilizing Synthea-generated FHIR resources. However, these resources do not cover all the necessary information required for a comprehensive reconstruction. Therefore, there is a need to develop custom extensions to these generated FHIR resources. This will ensure that all required information is captured and used effectively

#### Research question

How can the Synthea Patient Generator be extended with HL7 FHIR implementation guides to enhance its adaptability for local use in different healthcare settings?

#### Goals
Within this project and research the following 4 goals are set
##### 1. Ensure Compliance with Austrian Core Implementation Guidelines 
Generate patient profiles that align with the Austrian Core Implementation guidelines and any associated extensions to ensure regulatory compliance and interoperability within the Austrian healthcare system.


##### 2. Utilize Austrian Demographic Data:
 Incorporate accurate and representative demographic data specific to Austria to enhance the realism and relevance of the generated patient profiles, facilitating more accurate simulations and analysis.
##### 3. Model Clinical Processes for Local Medical Settings: 
Develop detailed models of clinical processes tailored to local medical settings, enabling the creation of synthetic patient histories that accurately reflect real-world medical procedures and workflows.

##### 4. Generate FHIR AuditEvent Resources for Process Mining:

Implement the generation of FHIR AuditEvent resources to capture and document healthcare processes, facilitating process mining and analysis for optimization and improvement purposes.

#### Read about Synthea

Read the Synthea [wiki](https://github.com/synthetichealth/synthea/wiki) and [Frequently Asked Questions](https://github.com/synthetichealth/synthea/wiki/Frequently-Asked-Questions) for more information. 

Synthea<sup>TM</sup> is a Synthetic Patient Population Simulator. The goal is to output synthetic, realistic (but not real), patient data and associated health records in a variety of formats.

Currently, Synthea<sup>TM</sup> features include:
- Birth to Death Lifecycle
- Configuration-based statistics and demographics (defaults with Massachusetts Census data)
- Modular Rule System
  - Drop in [Generic Modules](https://github.com/synthetichealth/synthea/wiki/Generic-Module-Framework)
  - Custom Java rules modules for additional capabilities
- Primary Care Encounters, Emergency Room Encounters, and Symptom-Driven Encounters
- Conditions, Allergies, Medications, Vaccinations, Observations/Vitals, Labs, Procedures, CarePlans
- Formats
  - HL7 FHIR (R4, STU3 v3.0.1, and DSTU2 v1.0.2)
  - Bulk FHIR in ndjson format (set `exporter.fhir.bulk_data = true` to activate)
  - C-CDA (set `exporter.ccda.export = true` to activate)
  - CSV (set `exporter.csv.export = true` to activate)
  - CPCDS (set `exporter.cpcds.export = true` to activate)
- Rendering Rules and Disease Modules with Graphviz

## Table of Contents
- [Developer Quick Start](#developer-quick-start)
  - [Installation](#installation)
  - [Changing the default properties](#changing-the-default-properties)
  - [Generate Synthetic Patients](#generate-synthetic-patients)
  - [Synthea<sup>TM</sup> GraphViz](#syntheatm-graphviz)
  - [Concepts and Attributes](#concepts-and-attributes)
- [Generic Modules Framework](#generic-modules-framework)
- [Demographic Data](#demographic-data)
- [AT Core Profile Implementation](#at-core-profile-implementation)
- [AuditEvent Resource Creation](#auditevent-resource-creation)


## Developer Quick Start

These instructions are intended for those wishing to examine the Synthea source code, extend it or build the code locally. Those just wishing to run Synthea should follow the [Basic Setup and Running](https://github.com/synthetichealth/synthea/wiki/Basic-Setup-and-Running) instructions instead.

### Installation

This project requires Python 3. Please follow the instructions below to install Python 3 on your system.

### Windows

1. Download the latest Python 3 installer from the official website: [Python Downloads](https://www.python.org/downloads/).
2. Run the installer and follow the on-screen instructions. Make sure to check the box that says "Add Python to PATH".

### macOS

Python 3 can be installed using Homebrew, a package manager for macOS.

1. Open Terminal.
2. Install Homebrew if you haven't already: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
3. Install Python 3: `brew install python`

### Linux

#### Ubuntu/Debian-based systems

1. Open Terminal.
2. Update package lists: `sudo apt update`
3. Install Python 3: `sudo apt install python3`

**System Requirements:**
Synthea<sup>TM</sup> requires Java JDK 11 or newer. We strongly recommend using a Long-Term Support (LTS) release of Java, 11 or 17, as issues may occur with more recent non-LTS versions.

To clone the Synthea<sup>TM</sup> repo, then build and run the test suite:
```
git clone https://github.com/Mitchvandenbroek/synthea-AT-implementation.git
cd synthea
./gradlew build check test
```

### Changing the default properties


The default properties file values can be found at `src/main/resources/synthea.properties`.
By default, synthea does not generate CCDA, CPCDA, CSV, or Bulk FHIR (ndjson). You'll need to
adjust this file to activate these features.  See the [wiki](https://github.com/synthetichealth/synthea/wiki)
for more details, or use our [guided customizer tool](https://synthetichealth.github.io/spt/#/customizer).



### Generate Synthetic Patients
Generating the population one at a time following the Austrian implementation guideline...
```
./run_synthea -fm MappingFile.yml -ig AT-IG
```

Where -fm references a mapping yml file that applies the extensions following the Austrian Core profile. and -ig references the Austrian Core Implementation Guideline.

It is recommeded to run this installation of synthea always with these arguments.
##### FHIR AuditEvent generation

```
./run_synthea -fm MappingFile.yml -ig AT-IG -ae
```

Where -ae enables the generation of the FHIR AuditEvent resource.

##### FHIR restcall
##### Expiremental feature !!!
```
./run_synthea -fm MappingFile.yml -ig AT-IG -ae -post http://uri
```

Where -post enables the post restcall to a FHIR server.

##### Arguments

Command-line arguments may be provided to specify a state, city, population size, or seed for randomization.
```
run_synthea ./run_synthea -fm MappingFile.yml -ig AT-IG [-s seed] [-p populationSize] [state [city]]
```

Full usage info can be printed by passing the `-h` option.
```
$ ./run_synthea -h     

> Task :run
Usage: run_synthea [options] [state [city]]
Options: [-s seed]
         [-cs clinicianSeed]
         [-p populationSize]
         [-r referenceDate as YYYYMMDD]
         [-g gender]
         [-a minAge-maxAge]
         [-o overflowPopulation]
         [-c localConfigFilePath]
         [-d localModulesDirPath]
         [-i initialPopulationSnapshotPath]
         [-u updatedPopulationSnapshotPath]
         [-t updateTimePeriodInDays]
         [-f fixedRecordPath]
         [-k keepMatchingPatientsPath]
         [-ae] Enable generation of the FHIR AuditEvent resource 
         [-post FHIR server uri] Posts generated fhir bundles to fhir server
         [--config*=value]
          * any setting from src/main/resources/synthea.properties

```

Some settings can be changed in `./src/main/resources/synthea.properties`.

Synthea<sup>TM</sup> will output patient records in C-CDA and FHIR formats in `./output`.

### Synthea<sup>TM</sup> GraphViz
Generate graphical visualizations of Synthea<sup>TM</sup> rules and modules.
```
./gradlew graphviz
```

### Concepts and Attributes
Generate a list of concepts (used in the records) or attributes (variables on each patient).
```
./gradlew concepts
./gradlew attributes
```

## Generic Modules Framework

This [link](GMF.md) describes the implementation and usage of the Generic Modules Framework designed for the local implementation of medical processes. It provides guidelines on creating and integrating custom modules to simulate specific healthcare scenarios and workflows. This flexibility allows users to tailor the synthetic data generation to their unique requirements and research goals.


## Demographic Data

This [link](Demographic.md) outlines the Austrian demographic data and implementation.


## AT Core Profile Implementation

This [link](Flexporter.md) describes the implementation of the AT Core Profile, including the integration of its extensions to enhance the synthetic patient data generated by Synthea. The AT Core Profile is designed to ensure compatibility with specific healthcare standards in Austria.

## AuditEvent Resource Creation

This [link](RuleBasedSystem.md) details the creation of the AuditEvent FHIR resource for process mining purposes within the Synthea Patient Generator using a rule based system. AuditEvent resources are generated to log significant actions and events within the synthetic data generation process, enabling detailed analysis and tracking of patient clinical patheways. This functionality is essential for auditing and validating the synthetic data for compliance and research needs.

## BundleViewer

To quickly view a FHIR Bundle and its contents you open the bundleViewer html page in `./BundleViewer/index.html` drag and drop a FHIR resource bundle to view its contents
This will display a fhir bundle as seen on [link](viewBundle.md)
This will also reveal the result of the implementation of this project.

## Conclusion of stated resource question

## Conclusion
### Intoduction


In this study, we aimed to explore how the Synthea Patient Generator can be extended with HL7 FHIR implementation guides to enhance its adaptability for local use in different healthcare settings. With four main goals in mind, namely, generating patient profiles adhering to the Austrian Core Implementation Guidelines and its extensions, utilizing Austrian demographic data, modeling clinical processes for specific processes in local medical settings, and generating FHIR AuditEvent resources for process mining purposes, we have made significant progress towards achieving these objectives.
### Key Findings

#### Generic Modules Framework:
Synthea's framework is flexible, allowing detailed simulations tailored to local healthcare needs.
#### Demographic Data:
Synthea can use accurate Austrian data with some adjustments, ensuring realistic patient profiles.
#### AT-coreprofile-mapping:
This config transforms patient data to meet Austrian standards, ensuring compliance.
#### Post processing for the FHIR AuditEvent Resources:
Many approaches can be applied to post process genereted data by Synthea to. like using different kind of AI models or rule-based systems to achieve the generation of the FHIR AuditEvent resource

## Implementation contributers
Contributers for this implementation for the Austrian guideline and Generic Framework Modules.

- [Mitch van den Broek](https://github.com/Mitchvandenbroek)
- [Selina Adlberger](https://github.com/SelAB10)

# License

Copyright 2017-2023 The MITRE Corporation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
