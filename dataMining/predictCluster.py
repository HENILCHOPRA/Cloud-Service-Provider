import pickle
import numpy as np
import pandas as pd
from sklearn.cluster import KMeans

model = pickle.load(open("model.pkl", "rb"))
budget = input('Enter budget: ')
xp = pd.DataFrame([budget])
x_dr = np.array(xp.iloc[:].values).reshape(1,-1)
print('It belongs to cluster number: {}'.format(model.predict(x_dr)))