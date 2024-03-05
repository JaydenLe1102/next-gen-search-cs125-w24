import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsRegressor, NearestNeighbors
from preprocess import data_preprocess
import pickle

X_lunch_data = data_preprocess()[1]

knn = KNeighborsRegressor(n_neighbors=15, metric='euclidean')
knn.fit(X_lunch_data[["Calories"]], X_lunch_data.index)


pickle.dump(knn, open("model_lunch.pkl", "wb"))