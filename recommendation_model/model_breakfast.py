import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsRegressor, NearestNeighbors
from preprocess import data_preprocess
import pickle

X_breakfast_data = data_preprocess()[0]

knn = KNeighborsRegressor(n_neighbors=15, metric='euclidean')
knn.fit(X_breakfast_data[["Calories"]], X_breakfast_data.index)


pickle.dump(knn, open("model_breakfast.pkl", "wb"))
print("success")