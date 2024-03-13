from app.main import bp
import requests
from flask import Flask, request, jsonify
import json
#Import openAI
import openai 
# from apikey import APIKEY
# import firebase_admin
# from firebase_admin import firestore
import pyrebase
import os
import firebase_admin
from firebase_admin import credentials, firestore, initialize_app
from app.config.creds import config, firebaseDatabaseConfig
from app.main.data import sample_recipe
from app.main.data import sample_user_info
from app.sleep_recommendation.sleep_recommendation import sleep_rec, sleep_time, goodness_of_sleep
from app.main.utils import convertSecondsToFloatingHours, getExerciseDurationNumber, getGenderNumber, convertLbsToKilogram, getExerciseDateYesterday, calculateExerciseScore
from app.main.diet_recommendation.preprocess import calc_bmr, cacl_calories, bmi_cal, bmi_result, increase_weight, decrease_weight, data_preprocess, maintain_weight, diet_score
from app.main.diet_recommendation.diet_rec import predict
import pandas as pd
import pickle 
from datetime import datetime, date

# Replace the config and firebaseDatabaseConfig with one in docs
#config = {
#}
#firebaseDatabaseConfig = {
#}

openai.api_key = "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"
# load and read from pickle file 
basePath = os.path.dirname(__file__) 

model_low_path = os.path.join(basePath, "diet_recommendation/model_low.pkl")
model_med_path = os.path.join(basePath, "diet_recommendation/model_med.pkl")
model_high_path = os.path.join(basePath, "diet_recommendation/model_high.pkl")
data_path = os.path.join(basePath, "diet_recommendation/data.pkl")

model_low = pickle.load(open(model_low_path, "rb"))
model_med = pickle.load(open(model_med_path, "rb"))
model_high = pickle.load(open(model_high_path, "rb"))
data = pickle.load(open(data_path, "rb"))
#data = data_preprocess()
#os.makedirs(os.path.dirname(data_path), exist_ok=True)
#pickle.dump(data, open(data_path, "wb"))

print("Done load model and preprocess data")

#Using pyrebase to authenticate
firebase = pyrebase.initialize_app(config)
auth = firebase.auth()
#Using firebase api to get access the firestore database
cred = credentials.Certificate(firebaseDatabaseConfig)
firebase_admin.initialize_app(cred)
db = firestore.client()


#utils
def getUserInfo(user_id_token):  
	user = auth.get_account_info(user_id_token)
	user_uid = user['users'][0]['localId']

	# Retrieve user information from Firestore
	user_info_doc = db.collection("users").document(user_uid).get()
	return user_info_doc.to_dict()




@bp.route('/', methods=['GET'])
def index():
    return 'Hello'

# Singup, Login, and Logout
@bp.route('/login', methods=['POST'])
def login():
    try:
        email = request.json['email']
        password = request.json['password']

        user = auth.sign_in_with_email_and_password(email, password)
        print(user)
        return jsonify({"message": "Login successful", "idToken": user['idToken'], "userID": user['localId']}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400

@bp.route('/signup', methods=['POST'])
def signup():
    try:
        email = request.json['email']
        password = request.json['password']
        print(email, password)
        auth.create_user_with_email_and_password(email, password)
        user = auth.sign_in_with_email_and_password(email, password)
        
        print(user)
        user_uid = user['localId']
        
        # Extract user information
        email = email
        today = date.today()
        print(today)
        today_str = today.strftime("%Y-%m-%d")

        # Store user information in Firestore
        user_info = {
            "email": email,
            "calories_consumed": 0,
            "exercisePlan": None,
            "createdDate": today_str          
        }
        
        print(user_info)

        db.collection("users").document(user_uid).set(user_info)
        
        return jsonify({"message": "Signup successful", "idToken": user['idToken'], "userID": user['localId']}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 400

@bp.route('/logout', methods=['POST'])
def logout():
    try:
        user_id_token = request.json['idToken']
        #clear the cached user
        auth.current_user = None 
        #auth.sign_out(user_id_token)
        return jsonify({"message": "Logout successful"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400


#Create, update user information
@bp.route('/userinfo', methods=['POST'])
def store_user_info():
    try:
        # Get user ID token from request
        user_id_token = request.json['idToken']
        print(user_id_token)
        # Verify user ID token
        user = auth.get_account_info(user_id_token)
        print(user)
        user_uid = user['users'][0]['localId']
        
        # Extract user information
        email = user['users'][0]['email']
        full_name = request.json['full_name']
        age = request.json['age']
        gender = request.json['gender']
        height= request.json['height']
        weight = request.json['weight']
        activity_level= request.json['activity_level']
        health_goal = request.json['health_goal']

        # Store user information in Firestore
        user_info = {
            "email": email,
            "full_name": full_name,
            "age": age,
            "gender": gender,
            "height": height,
            "weight": weight,
            "activity_level": activity_level,
            "health_goal": health_goal
            # Add additional fields here as needed
        }
        print(user_uid)
        db.collection("users").document(user_uid).set(user_info)
        # db.child("users").child(user_uid).set(user_info)

        return jsonify({"message": "User information stored successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400
    
    
#Create, update user information
@bp.route('/userinfo', methods=['PATCH'])
def update_user_info():
    try:
        # Get user ID token from request
        user_id_token = request.json['idToken']
        print(user_id_token)
        # Verify user ID token
        user = auth.get_account_info(user_id_token)
        print(user)
        user_uid = user['users'][0]['localId']
        
        # Extract user information
        email = user['users'][0]['email']
        
        update_info = request.json
        
        
        del update_info["idToken"]

        
        if ("weight" in update_info.keys()):
            today = date.today()
            today_str = today.strftime("%Y-%m-%d")
            update_info["last_update_weight"] = today_str
        
        print(f'update_info: {update_info}')
        db.collection("users").document(user_uid).update(update_info)
        # db.child("users").child(user_uid).set(user_info)

        return jsonify({"message": "User information update successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400

#GET user information
@bp.route('/userinfo', methods=['GET'])
def get_user_info():
    try:
        
        user_id_token = request.args.get('idToken')
        
        #return sample_user_info, 200
        user_info = getUserInfo(user_id_token)

        if user_info:
            return jsonify(user_info), 200
        else:
            return jsonify({"error": "User information not found"}), 404

    except Exception as e:
        return jsonify({"error": str(e)}), 400

    
# GET the food recipe
@bp.route('/get_recipes', methods=['GET'])
def get_recipes():
    try:
        
        return sample_recipe,200
        
        ## Get the query parameters from the request
        #query = request.args.get('query', default='', type=str)
        #min_calories = request.args.get('minCalories', default=200, type=int)
        #max_calories = request.args.get('maxCalories', default=500, type=int)
        #number = request.args.get('number', type=int)
        
        ## API KEY 
        #api_key = '597f65db5ee4465eb2691af5fa79484a'
        ## Define the endpoint URL
        #endpoint = 'https://api.spoonacular.com/recipes/complexSearch'
        ## Define the query parameters
        #params = {
        #    'query': query,
        #    'minCalories': min_calories,
        #    'maxCalories': max_calories,
        #    'number': number,
        #    'apiKey': api_key
        #}
        
        #print("calling the spoon api")
        
        ## Make the GET request to the API
        #response = requests.get(endpoint, params=params)
        
        ## Check if the request was successful
        #if response.status_code == 200:
            
        #    #loop through the response
        #    recipes = []
        #    for recipe in response.json()['results']:
        #        recipe_id = recipe['id']
        #        recipe_title = recipe['title']
        #        recipe_image = recipe['image']
        #        recipe_cal = recipe['nutrition']['nutrients'][0]['amount']
        #        cal_unit = recipe['nutrition']['nutrients'][0]['unit']
                
        #        recipes.append({
        #            'id': recipe_id,
        #            'title': recipe_title,
        #            'imageUrl': recipe_image,
        #            'calories': str(recipe_cal) + " " + cal_unit
        #        })
            
        #    # Return the JSON response from the API
        #    return recipes, 200
        #else:
        #    # Return an error message if the request was not successful
        #    return jsonify({"error": f"Failed to retrieve recipes. Status code: {response.status_code}"}), response.status_code
    except Exception as e:
        # Return an error message if an exception occurred
        return jsonify({"error": str(e)}), 400
    
    
@bp.route('/get_sleep', methods=['GET'])
def get_sleep():
    try:
        user_id_token = request.args.get('idToken')
        user_info = getUserInfo(user_id_token)
        user_age = user_info['age']
        sleep_recommendation = sleep_rec(int(user_age))
        
        if (sleep_recommendation):
            return jsonify(sleep_recommendation), 200
        else:
            return jsonify({"error": "Only support age from 14 to 65"}), 400
        

    except Exception as e:
        return jsonify({"error": str(e)}), 400

    
@bp.route('/get_sleep_point', methods=['GET'])
def get_sleep_point():
    try:
        user_id_token = request.args.get('idToken')
        
        #return sample_user_info, 200
        user_info = getUserInfo(user_id_token)
        print("getting sleep point ", user_info['sleep_time_yesterday'])
        sleep_track = convertSecondsToFloatingHours(float(user_info['sleep_time_yesterday']))

        sleep_recommendation = sleep_rec(int(user_info['age']))
        
        print("sleep_recommendation/point", sleep_recommendation, sleep_track)
        
        sleep_point = goodness_of_sleep(sleep_track, sleep_recommendation)
        
        sleep_point = {
            "sleep_point": sleep_point
        }
        
        return sleep_point, 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400
    
@bp.route('/get_exercise', methods=['GET'])
def exercise():
    try:
        user_id_token = request.args.get('idToken')
        #return sample_user_info, 200
        user_info = getUserInfo(user_id_token)
        
        if (user_info["exercisePlan"] == None):
            # Get parameters from the request
            gender = user_info['gender']
            age = user_info['age']
            weight = user_info['weight']
            height = user_info['height']
            preference = user_info['health_goal']  
            activityLevel = user_info['activity_level']

            if activityLevel == "Beginner":
                workoutTime = "30 minutes"
            elif activityLevel == "Intermediate":
                workoutTime = "1 hour"
            elif activityLevel == "Professional":
                workoutTime = "2 hours"
            else:
                workoutTime = "10 minutes"
                

            # Generate prompt based on parameters
            prompt = f"Creating a work out plan for 7 days, with 6 recommendation of exercises in a day that adds up to total of {workoutTime} with title, length, calories burned, and instruction for a {gender} aged {age} weighing {weight}lbs and {height} tall, who wants to {preference} in JSON Format. Having fixed json format of day_1:[list of exercise object inside] to day_7:[list of exercise object inside]. Always fill out all the day from 1 to 7 exercises."

            # Generate exercise recommendations using OpenAI's GPT-3.5 model
            response = openai.chat.completions.create(
                model="gpt-3.5-turbo",
                messages=[
                    {"role": "user", "content": prompt}
                ]
            )

            # Extract exercise recommendations from the API response
            exercise_data_str = response.choices[0].message.content
            # Parse exercise data as JSON
            try:
                exercise_data = json.loads(exercise_data_str)
            except json.JSONDecodeError as e:
                return jsonify({"error": str(e)}), 500

            # # Generate images for each exercise title
            # for exercise in exercise_data['exercises']:
            #     # Generate image prompt
            #     image_prompt = f"Generate cartoon of {exercise['title']} exercise"

            #     # Generate image using DALL-E model
            #     image_response = openai.images.generate(
            #         model="dall-e-2",
            #         prompt=image_prompt,
            #         size="1024x1024",
            #         quality="standard",
            #         n=1,
            #     )

            #     # Get image URL from the response and add it to the exercise data
            #     image_url = image_response.data[0].url
            #     exercise['image_url'] = image_url
            # Return exercise recommendations with image URLs as JSON response
            
            user = auth.get_account_info(user_id_token)
            user_uid = user['users'][0]['localId']
            update_info = {
                "exercisePlan": exercise_data
            }
            db.collection("users").document(user_uid).update(update_info)
            
            return exercise_data, 200
        else:
            return user_info["exercisePlan"], 200
            
    except Exception as e:
        return jsonify({"error": str(e)}), 400

@bp.route('/get_exercise_score', methods=['GET'])
def get_exercise_score():
    
    try:
        user_id_token = request.args.get('idToken')
        #return sample_user_info, 200
        user_info = getUserInfo(user_id_token)
        
        createdDate = date.fromisoformat(user_info['createdDate'])
        
        todayDate = date.today()
        
        return jsonify({"exercise_score" : calculateExerciseScore(createdDate, todayDate, user_info)}), 200
        
    except Exception as e:
        return jsonify({"error": str(e)}), 400
    
    
@bp.route('/get_exercise_day', methods=['GET'])
def get_exercise_day():
    
    try:
        user_id_token = request.args.get('idToken')
        #return sample_user_info, 200
        user_info = getUserInfo(user_id_token)
        
        createdDate = date.fromisoformat(user_info['createdDate'])
        
        todayDate = date.today()
        
        exerciseDate = getExerciseDateYesterday(createdDate, todayDate) 
        if (exerciseDate == 7):
            exerciseDate = 1
        else:
            exerciseDate += 1
            
        return jsonify({"exercise_day" : exerciseDate}), 200
        
    except Exception as e:
        return jsonify({"error": str(e)}), 400
    
    
    
@bp.route('/get_bmi_rec', methods=['GET'])
def get_bmi_rec():
    
    options = ["Lose weight", "Remain weight", "Gain weight"]
    
    try:
        user_id_token = request.args.get('idToken')
        
        user = auth.get_account_info(user_id_token)
        user_uid = user['users'][0]['localId']
     
        user_info = getUserInfo(user_id_token)
        
        print(user_info)
        print("hello world")
        
        user_weight = convertLbsToKilogram(float(user_info['weight']))
        user_height = float(user_info['height'])
        user_age = int(user_info['age'])
        user_gender = getGenderNumber(user_info['gender'])
        user_exercise_duration = getExerciseDurationNumber(user_info['activity_level'])
        
        bmi = bmi_cal(user_weight, user_height) #showing bmi as an additional information for user health
        bmr = calc_bmr(user_weight,user_height,user_age, user_gender) #bmr will allow to calculate the calories intake
        calories = cacl_calories(bmr, user_exercise_duration)
        
        
        update_info = {
            "caloriesIntakeRec": calories,
        }
        db.collection("users").document(user_uid).update(update_info)
        
        return jsonify({"caloriesIntakeRec":calories, "Recommended Option": options[bmi]}), 200
        
    except Exception as e:
        return jsonify({"error": str(e)}), 400




@bp.route('/get_diet', methods=['GET'])
def get_diet():
    try:
        user_id_token = request.args.get('idToken')
        user_info = getUserInfo(user_id_token)
        user_caloriesIntakeRec = float(user_info['caloriesIntakeRec'])
        
        user_health_goal = user_info['health_goal']
        
        all_choices = None
        
        if user_health_goal == "Lose Weight":
            desired_weight_loss = user_info['weight'] - user_info['target_weight']
            # Retrieve calories from session
            calories = user_caloriesIntakeRec
            
            low_target_cal, med_target_cal, high_target_cal = decrease_weight(calories, desired_weight_loss)
            rand_breakfast = predict(model_low, low_target_cal)
            rand_lunch = predict(model_med, med_target_cal)
            rand_dinner = predict(model_high, high_target_cal)

            nearest_neighbors_breakfast = data.iloc[rand_breakfast[:8]]
            nearest_neighbors_lunch = data.iloc[rand_lunch[:8]]
            nearest_neighbors_dinner = data.iloc[rand_dinner[:8]]

            #turn to DataFrame
            top_breakfast = nearest_neighbors_breakfast[['Name', 'CookTime', 'Calories', 'RecipeInstructions', 'Images']]
            top_lunch = nearest_neighbors_lunch[['Name', 'CookTime', 'Calories', 'RecipeInstructions', 'Images']]
            top_dinner = nearest_neighbors_dinner[['Name', 'CookTime', 'Calories', 'RecipeInstructions', 'Images']]
            all_choices = pd.concat([top_breakfast, top_lunch, top_dinner], ignore_index=True)

        elif user_health_goal == "Gain Weight":
            
            desired_weight_gain = user_info['target_weight'] - user_info['weight']
            desired_weight_gain = convertLbsToKilogram(desired_weight_gain)
            calories = user_caloriesIntakeRec
                  
            low_target_cal, med_target_cal, high_target_cal = increase_weight(calories, desired_weight_gain)
            rand_breakfast = predict(model_low, low_target_cal)
            rand_lunch = predict(model_med, med_target_cal)
            rand_dinner = predict(model_high, high_target_cal)
            
            nearest_neighbors_breakfast = data.iloc[rand_breakfast[:8]]
            nearest_neighbors_lunch = data.iloc[rand_lunch[:8]]
            nearest_neighbors_dinner = data.iloc[rand_dinner[:8]]
        
            #turn to DataFrame
            top_breakfast = nearest_neighbors_breakfast[['Name', 'CookTime', 'Calories', 'RecipeInstructions', 'Images']]
            top_lunch = nearest_neighbors_lunch[['Name', 'CookTime', 'Calories', 'RecipeInstructions', 'Images']]
            top_dinner = nearest_neighbors_dinner[['Name', 'CookTime', 'Calories', 'RecipeInstructions', 'Images']]
            all_choices = pd.concat([top_breakfast, top_lunch, top_dinner], ignore_index=True)
        else:
            low_target_cal, med_target_cal, high_target_cal = maintain_weight(user_caloriesIntakeRec)
            rand_breakfast = predict(model_low, low_target_cal)
            rand_lunch = predict(model_med, med_target_cal)
            rand_dinner = predict(model_high, high_target_cal)
            
            nearest_neighbors_breakfast = data.iloc[rand_breakfast[:8]]
            nearest_neighbors_lunch = data.iloc[rand_lunch[:8]]
            nearest_neighbors_dinner = data.iloc[rand_dinner[:]]
        
            #turn to DataFrame
            top_breakfast = nearest_neighbors_breakfast[['Name', 'CookTime', 'Calories', 'RecipeInstructions', 'Images']]
            top_lunch = nearest_neighbors_lunch[['Name', 'CookTime', 'Calories', 'RecipeInstructions', 'Images']]
            top_dinner = nearest_neighbors_dinner[['Name', 'CookTime', 'Calories', 'RecipeInstructions', 'Images']]
            all_choices = pd.concat([top_breakfast, top_lunch, top_dinner], ignore_index=True)

        all_choices = all_choices.to_dict(orient='records')

        return jsonify(all_choices), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400
    
    
    
@bp.route('/get_diet_score', methods=['GET'])
def get_diet_score():
    print("getting diet score")
    try:
        user_id_token = request.args.get('idToken')
        calories_consumed = request.args.get('calories_consumed')
        
        user_info = getUserInfo(user_id_token)
        
        user = auth.get_account_info(user_id_token)
        user_uid = user['users'][0]['localId']
        
        print("calories_consumed ", calories_consumed)
        print("user_info['calories_consumed'] ", user_info['calories_consumed'])
        print("helloworld")
        print(user_info['calories_consumed'] != None )
        print(float(user_info['calories_consumed']) != 0)
        
        if (float(calories_consumed) == 0.0 and user_info['calories_consumed'] != None and user_info['calories_consumed'] != 0):
            print("got here hello hehe")
            calories_consumed = user_info['calories_consumed']
        else:
            calories_consumed = float(calories_consumed)
            
        update_info = {
            "calories_consumed": calories_consumed
        }
        
        db.collection("users").document(user_uid).update(update_info)
        
        score = diet_score(float(calories_consumed), float(user_info['caloriesIntakeRec']))
        
        print("returning diet score")
        print("score", score)
        
        return jsonify({"diet_score": score, "caloriesIntakeRec":float(user_info['caloriesIntakeRec']), "calories_consumed": calories_consumed}), 200
    
    except Exception as e:
        return jsonify({"error": str(e)}), 400
    
    
@bp.route('/get_day_score', methods=['GET'])
def get_week_score():
    print("getting diet score")
    try:
        user_id_token = request.args.get('idToken')

        
        user = auth.get_account_info(user_id_token)
        user_uid = user['users'][0]['localId']
        
        
        user_info = getUserInfo(user_id_token)
        
        calories_consumed = user_info['calories_consumed']
        if user_info['calories_consumed'] == None:
            calories_consumed = 0
            
        if user_info['sleep_time_yesterday'] == None:
            sleep_time = 0
        else:
            sleep_time = user_info['sleep_time_yesterday']
        
        
        diet = diet_score(float(calories_consumed), float(user_info['caloriesIntakeRec']))
        
        sleep_track = convertSecondsToFloatingHours(float(sleep_time))

        sleep_recommendation = sleep_rec(int(user_info['age']))
        
        sleep = goodness_of_sleep(sleep_track, sleep_recommendation)
        
        createdDate = date.fromisoformat(user_info['createdDate'])
        
        todayDate = date.today()
        
        exercise = calculateExerciseScore(createdDate, todayDate, user_info)
        
        return jsonify({"day_score": float(diet + sleep + exercise)}), 200
    
    except Exception as e:
        return jsonify({"error": str(e)}), 400
