import pymysql
import pandas as pd

conn = pymysql.connect(host='127.0.0.1', user='root', password='1234', db='cloudcomputingDB')
cursor = conn.cursor()

def loadCSVIntoTable(csvInfo):
	data = pd.read_csv(csvInfo[0])   
	df = pd.DataFrame(data)
	df.fillna(0, inplace=True)
	for row in df.itertuples():
		cursor.execute(csvInfo[1],row[2:])
	print('Done loading {}'.format(csvInfo[0]))
	conn.commit()


csvInfoList = [
['./data/payDF.csv', '''INSERT INTO paymentInformation (payID, methodType) VALUES (%s,%s)'''],
['./data/auth_df.csv', '''INSERT INTO authorization (authID, userName, password) VALUES (%s,%s,%s)'''],
['./data/userDF.csv', '''INSERT INTO user (userID, name, email, contactNumber, payID, authID) VALUES (%s,%s,%s,%s,%s,%s)'''],
['./data/storage_df.csv', '''INSERT INTO storage (size, type, storageID, price) VALUES (%s,%s,%s,%s)'''],
['./data/compute_df.csv', '''INSERT INTO computing (ram, coreCount, gpu, computeID, price) VALUES (%s,%s,%s,%s,%s)'''],
['./data/instance_df.csv', '''INSERT INTO instance (instanceID, zone, allocated, computeID, storageID, instanceType) VALUES (%s,%s,%s,%s,%s,%s)'''],
['./data/sub_df.csv', '''INSERT INTO storage (size, type, storageID, price) VALUES (%s,%s,%s,%s)''']
]

for csvInfo in csvInfoList:
	loadCSVIntoTable(csvInfo)

cursor.close()
conn.close()