import csv

def remove_first_column(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w', newline='') as outfile:
        reader = csv.reader(infile)
        writer = csv.writer(outfile)
        for row in reader:
            writer.writerow(row[1:])  # Write all columns except the first one

# Usage example:
input_file = 'zipcodes.csv'
output_file = 'output.csv'
remove_first_column(input_file, output_file)
print("First column removed successfully!")
