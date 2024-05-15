import os
import json

# Specify the directory containing your JSON files
directory_path = "output/fhir"

# Iterate through each file in the directory
for filename in os.listdir(directory_path):
    if filename.endswith(".json"):  # Check if the file is a JSON file
        file_path = os.path.join(directory_path, filename)  # Get the full path of the file
        
        # Open the JSON file and load its contents
        with open(file_path, "r") as file:
            data = json.load(file)
    
        for entry in data["entry"]:
            print("Full URL:", entry["fullUrl"])
            print("Resource:", entry["resource"])
            print()