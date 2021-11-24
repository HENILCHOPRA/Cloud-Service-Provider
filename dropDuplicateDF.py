import pandas as pd

data = pd.read_csv('./data/bills_df.csv')   
df = pd.DataFrame(data)
print(df)
df.drop_duplicates(subset ="bill_id",keep = False, inplace = True)
print(df)
df.to_csv('./data/bills_df.csv', index=False)