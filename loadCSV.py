import pymysql

mydb = pymysql.connect(
  host="localhost",
  user="root",
  password="1234",
  database="cloudcomputing"
)

cur = mydb.cursor()

"""
query1 = "INSERT INTO tableName (column1, column2) VALUES (%s, %s)"
val = ("column1value", "column2value")
mycursor.execute(query1, val)
mydb.commit()
print(mycursor.rowcount, "record inserted.")
"""

cur.execute("SELECT VERSION()")

data = cur.fetchone()
print("Database version : %s " % data)

mydb.close()