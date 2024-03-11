from app.main import bp
import requests
from flask import Flask, request, jsonify
# import firebase_admin
# from firebase_admin import firestore
import pyrebase
import firebase_admin
from firebase_admin import credentials, firestore, initialize_app
from app.config.creds import config, firebaseDatabaseConfig
from app.main.data import sample_recipe
from app.main.data import sample_user_info
from app.sleep_recommendation.sleep_recommendation import sleep_rec, sleep_time, goodness_of_sleep
from app.main.utils import convertSecondsToFloatingHours



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
        auth.create_user_with_email_and_password(email, password)
        return jsonify({"message": "Signup successful"}), 201
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
        dietary_preference = request.json['dietary_preference']
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
            "dietary_preference": dietary_preference,
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
        
        sleep_track = convertSecondsToFloatingHours(user_info['sleep_time_yesterday'])

        sleep_recommendation = sleep_rec(int(user_info['age']))
        
        sleep_point = goodness_of_sleep(sleep_track, sleep_recommendation)
        
        return sleep_point, 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400
    
