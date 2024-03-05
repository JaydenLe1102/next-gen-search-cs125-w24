import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsRegressor, NearestNeighbors
from preprocess import data_preprocess
import pickle

X_dinner_data = data_preprocess()[2]

knn = KNeighborsRegressor(n_neighbors=15, metric='euclidean')
knn.fit(X_dinner_data[["Calories"]], X_dinner_data.index)

#make a pickle file from model 
pickle.dump(knn, open("model_dinner.pkl", "wb"))