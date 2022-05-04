import pandas as pd
import csv

# open the file in the write mode
f = open('./keywords.csv', 'w')

# create the csv writer
writer = csv.writer(f)

# write header file
writer.writerow(['id', 'keyword'])

df = pd.read_csv(r"../Datasets/tmdb-movies.csv")

N = df.shape[0]

print(N)

for i in range(N):
    id = df.id[i]
    x = df.keywords[i]
    try:
        y = x.split('|')
        for ac in y:
            r = [id, ac]
            writer.writerow(r)
    except:
        continue



# close the file
f.close()