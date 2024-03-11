import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsRegressor, NearestNeighbors
from preprocess import data_preprocess
import pickle

#for high calories

X = data_preprocess()

knn = KNeighborsRegressor(n_neighbors=15, metric='euclidean')
knn.fit(X[["Calories"]], X.index)

#make a pickle file from model 
pickle.dump(knn, open("model_high.pkl", "wb"))