# Synthea<sup>TM</sup> Patient Generator with AT Core Profile Implementation ![Build Status](https://github.com/synthetichealth/synthea/workflows/.github/workflows/ci-build-test.yml/badge.svg?branch=master) [![codecov](https://codecov.io/gh/synthetichealth/synthea/branch/master/graph/badge.svg)](https://codecov.io/gh/synthetichealth/synthea)

Synthea<sup>TM</sup> is a Synthetic Patient Population Simulator. The goal is to output synthetic, realistic (but not real), patient data and associated health records in a variety of formats.

This repository is a fork of the Synthea<sup>TM</sup> Patient Generator, enhanced for the implementation of the AT Core Profile with its extensions and demographic data. It also includes the generation of the AuditEvent FHIR resource for process mining purposes in the PICA project and specific modules for local implementation of medical processes.

#### PICA - Process Intelligence and Conformance Auditing.

The project is concerned with the development and establishment of a process analytics connection for medical information systems, which can be used to create a “digital twin” of organizational processes. The development is based on internationally established communication standards in healthcare and in coordination with the Austrian affiliate organization HL7 Austria. Among other things, this will result in a publicly available implementation guideline that will be further developed on an ongoing basis. The implementation guide can be found at [AIST PICA Implementation Guide](https://fhir.hl7.at/r5-pica-5-deployment/index.html) 

#### Read about Synthea

Read the Synthea [wiki](https://github.com/synthetichealth/synthea/wiki) and [Frequently Asked Questions](https://github.com/synthetichealth/synthea/wiki/Frequently-Asked-Questions) for more information. 


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

**System Requirements:**
Synthea<sup>TM</sup> requires Java JDK 11 or newer. We strongly recommend using a Long-Term Support (LTS) release of Java, 11 or 17, as issues may occur with more recent non-LTS versions.

To clone the Synthea<sup>TM</sup> repo, then build and run the test suite:
```
git clone https://github.com/synthetichealth/synthea.git
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
