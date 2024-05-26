# PICA Project: Austrian Demographic Data 

For the realistic implementation of the PICA project, accurate Austrian demographic data is essential. The required data includes:

- **Geographical Data**: Information about the geography of Austria.
- **Service Providers**: Details about various service providers in Austria.
- **Insurance Providers**: Information about insurance providers operating in Austria.
- **Names**: Common first and last names in Austria.
- **Religion**: Possible religions for the purpose of the AT-Core implementation.

## Data Sources

To implement this project, data from the [Synthea International GitHub repository](https://github.com/synthetichealth/synthea-international/tree/master) is utilized. Here demographic data from various regions can be found.
This repository sources its data from various platforms:

- **Providers**: Extracted from OpenStreetMaps.
- **Zip Codes, City Names, and Populations**: Obtained from Geonames.org.
- **Demographic Data**: Finnish demographic data is replicated across all European countries.

´
- **Religion**: List of supported religions with id's and names, based on the [Österreichischer e-Health-Terminologie-Browser](https://termgit.elga.gv.at/CodeSystem-hl7-at-religionaustria.html). distribution is based on a rough estimations.


## usage 

```
git clone https://github.com/synthetichealth/synthea
git clone https://github.com/synthetichealth/synthea-international
cd synthea-international
cp -R at/* ../synthea
```
## Data Issues and Considerations

While using the Synthea International data, several issues may arise:

1. **Phone Numbers**: The data contains phone numbers in the US format, which is incorrect for Austrian data.
2. **Null Values**: There are numerous null values within the dataset.
3. **Inconsistent data format**: The format of the data is not 1 to 1 compared to the US implementation.
4. **Unusual characters**: There are numerous unusual characters in the demographic Austrian demographic data that are not easily interpret by machine.


### Solutions

To address these issues, the following steps are necessary:

- **Manual Implementation**: Manually correct or fill in the missing data values and fix the formatting issues.
- **Data Cleaning**: Remove entire records that contain significant null values if manual correction is not feasible.
- **Exceptions and different implementation for charactes**: Write exceptions or work arrounds for unuesual characters

By addressing these issues, the data can be made suitable for the realistic implementation of the PICA project, ensuring accurate representation of Austrian demographics.
## Conclusion

Synthea can be effectively extended with accurate demographic data for Austria, provided by Synthea International, with some necessary adjustments. If the Synthea International repository includes the required demographic data, it can be adapted to fit the specific needs of the PICA project through careful data cleaning and manual adjustments where needed. However, if Synthea International does not cover certain aspects required for an implementation, alternative methods will need to be explored. These may include sourcing data from other repositories or governmental databases.