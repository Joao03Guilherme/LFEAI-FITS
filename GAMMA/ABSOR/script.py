import csv 
from sys import argv, stdout
from math import sqrt

def calculate_total_counts(file_path):
    with open(file_path, 'r') as file:
        reader = csv.reader(file)

        for _ in range(5):
            next(reader)

        total_counts = 0
        for row in reader:
            try:
                total_counts += int(row[1])
            except IndexError:
                pass

    return total_counts

if __name__ == '__main__':
    total = calculate_total_counts(argv[1])
    print(f"${total} \\pm {round(sqrt(total))}$", file=stdout)


