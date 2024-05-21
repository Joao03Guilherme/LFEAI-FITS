import csv 


def get_sum_between_x0_and_x1(filepath, x0, x1):
    with open(filepath, "r") as file:
        reader = csv.reader(file)
        sum = 0
        for row in reader:
            # Skip first 5 rows
            if reader.line_num <= 5:
                continue

            # Check if the value is between x0 and x1
            if x0 <= float(row[0]) <= x1:
                sum += float(row[1])

        return sum
    
print(get_sum_between_x0_and_x1("CS.txt", 350, 385))

