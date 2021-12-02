import re
import numpy as np 
import os

path = 'data/experiment_data/Subject06/Subject06_train/'
file_list = os.listdir(path)

for filename in list(filter(lambda x: ".dat" in x, file_list)):
    print("File :", filename)
    processed_rows = []
    metadata = ""
    with open(path + filename, "r") as datafile:
        for i, line in enumerate(datafile):
            if i < 20:
                metadata += line 
            if i == 27:
                variable_names = list(filter(None, line.split("  ")))[:-1]
            if i >= 29:
                row = list(map(lambda x: float(x), list(filter(lambda x: x != "", re.split(" |, \t |\*|\n", line)))))
                processed_rows.append(row)

    row_array = np.asarray(processed_rows)
    header = metadata + ", ".join(variable_names)
    new_filename = "data/preprocessed_data/Subject06/Subject06_train/" + filename
    np.savetxt(new_filename, row_array, delimiter=", ", header=header)

