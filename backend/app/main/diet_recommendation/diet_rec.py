import numpy as np

def predict(knn_model, target_calorie):
    # Use knn_model.predict to get predictions
    # predictions = knn_model.predict([[target_calorie]])
    
    # Find the nearest neighbors based on predictions
    # rand_indices = np.argsort(predictions)[0]
    # print(rand_indices)
    # # Shuffle the indices to get random neighbors
    # np.random.shuffle(rand_indices)
    rand_indices = np.random.permutation(knn_model.kneighbors([[target_calorie]])[1][0])
    return rand_indices


    

