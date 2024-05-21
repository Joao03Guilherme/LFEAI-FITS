# Calc sum of all entries in column 1 of a CSV file 

import csv

def sum_column1(filename):
    with open(filename, 'r') as f:
        reader = csv.reader(f)
        
        # Skip all rows that start dont have a number in the first column
        soma = 0
        for row in reader:
            try:
                soma += int(row[1])
            except:
                pass
        return soma
    
# Usage
# scraper.py <filename>

import sys
filename = sys.argv[1]
print(sum_column1(filename))