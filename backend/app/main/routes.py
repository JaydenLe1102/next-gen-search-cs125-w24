from app.main import bp
import requests
from flask import Flask, request, jsonify
# import firebase_admin
# from firebase_admin import firestore
import pyrebase
import firebase_admin
from firebase_admin import credentials, firestore, initialize_app

# Replace the config and firebaseDatabaseConfig with one in docs
config = {
 'apiKey': "AIzaSyAgTCgwmHagAMa59FfdSnKAwchZg51OQCw",
 'authDomain' : "cs125-project-b6ea5.firebaseapp.com",
 'projectId' : "cs125-project-b6ea5",
 'storageBucket' : "cs125-project-b6ea5.appspot.com",
 'messagingSenderId' : "63446463144",
 'appId' : "1:63446463144:web:5f3d8e158538109690489d",
 'measurementId': "G-YKGZ6Q2317",
 'databaseURL' : ""
}
firebaseDatabaseConfig = {
 "type": "service_account",
 "project_id": "cs125-project-b6ea5",
 "private_key_id": "dd0c9c4f9c1ce6cf374ba187965a12582f24f09c",
 "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCzpJsIw/Hhp6cA\njAFGEFU/ffcjNTrZqan8jd7TL+tzWEVDxPfuUIkoBvDUbAwU8XilSyKjGu/lEHPq\npxn3ClkyzNsghM/KAtnYylDFlpPHRz8m/xYllUXsdYonjUx4egXyugQ0jMsPj2O3\n8fHs10iglmNklPP2c0KrSVi7R07AMfcC48dftQ9eNPprG82TL+I1NV/qsXXc/KHm\nTzHGne+ZUDbARiQuroxEDYEb3H7RmZPFBUYWkqEGbwi7X18mcDZd6FjaSSI4/wqT\nHakWIL5TvrW2YwV1Lx2NB3v4RMSDUu9R+0ygKGVnYcU4K8iLpzuJMc+FjND8vnll\nef7wZGE7AgMBAAECggEADgLXIrJhsbdpQ5Yn3UaV14tkFKdorSRaATwxdmhE5Wyr\njlMVAU3fvLL54p+Au7tvrPi0vWLy9fs4B0O8NzPj7B3lM16YdEmPoyR4c0jAwuiw\nKML5f7nqR7yNJ3OSVM0znJBclpqqlc6ZuPWSaGYMIJZKL0Sc2Ip51zEzzfuMTVoW\nzyqvn1JN+E10huU/ZYRR1GWwvzi8ywCdJCtIH+ANGd2aBYDGzJdSxrLM46IS00jU\nwayz3NLh9Ax2q9ZfvujnI/ZNnq8IsJkpNKCdNzPPKqOxo1l+Egjy4vtBEZewl+ST\ncRUsrhkN1p54WunDAE6RXes4IpHOt4/3DuTx2bLPQQKBgQDe/NUmwdWUY2mWHgLu\nGtyRwtHFBKYoH7MEWE0Xfoy1HU7UVXyelcZVdEVhNP5MWKhRUoNf3s8/gSiD/jf5\nFBbG4VmObslOwntSV66gCQfhml4l65DO9S9dgb3+NpzA37cs1UvhYvhEXIz0VdsP\nQm2Zxnu2ZNfCGCZLTwa6TmUzwQKBgQDOPQYMeGoYj5hkAhV6SfAIN1CkMYUuJmRH\nDAVxiyUWbb8hTcYtG2SAiG84/y9ouDbyvVvVkFkXM15fQvlLAzeAa+IGWFW2YhAj\nOGmoxodaKPHDjQ/k8C8uznQ8FIGEGSUlZLCIWUXeTD/etnyZ1JP5IZ1UT8NkhEAa\nT9hsfedj+wKBgQC4gJaVNPjViNQKg9aE0PEEIiCTVd9tf50N0UooUGt4SEG7auhs\nBx1OA6CMZ96pqQnMD+vn3WG599JgNG53x2l5MWh6c6xZYI3NegNhI1fEEYgo9Bqj\nQzfntLxRpTpaVEEp9WqNmOg3GCUA3jEdFSe+fv5J0nK7hGPbGA5HBSqzgQKBgQCd\nT3S+rFaY92bQ2boSNjWNvsuXAmLIqeYRPz0jt3QJoJqKR62jGGLXm7niqts5sFHR\nY9iZlOovxTH1zbsjmYeLQD7+ggCXBkOy6cPGRfBWOCb49y8pfH8w369PaIDGBvwL\ngrsYtaeSgWyyb1WpbLmV7Sr5dYHfuPTAXSkC0CJgYwKBgQCddingaUB3pJskx7Jz\nypwPPEObPymAIUBbs87wbcnvPiAssmLgQiORkyOIQuBJdeyYpnQq+8aLuE1RygNN\nx6Yhbjodacdk3C0Tn3la+qHfwbqZuK2u/ES4ZltdSVTmmds8J2nDFdbGoZzLTyJj\nLP1puSBL9kCwPWaOa8RTm16nEw==\n-----END PRIVATE KEY-----\n",
 "client_email": "firebase-adminsdk-i1e1f@cs125-project-b6ea5.iam.gserviceaccount.com",
 "client_id": "104547378401358564479",
 "auth_uri": "https://accounts.google.com/o/oauth2/auth",
 "token_uri": "https://oauth2.googleapis.com/token",
 "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
 "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-i1e1f%40cs125-project-b6ea5.iam.gserviceaccount.com",
 "universe_domain": "googleapis.com"
}


#Using pyrebase to authenticate
firebase = pyrebase.initialize_app(config)
auth = firebase.auth()
#Using firebase api to get access the firestore database
cred = credentials.Certificate(firebaseDatabaseConfig)
firebase_admin.initialize_app(cred)
db = firestore.client()

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
        auth.sign_out(user_id_token)
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
        first_name = request.json['first_name']
        last_name = request.json['last_name']
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
            "first_name": first_name,
            "last_name": last_name,
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
    

@bp.route('/get_recipes', methods=['GET'])
def get_recipes():
    try:
        # Get the query parameters from the request
        query = request.args.get('query', default='', type=str)
        min_calories = request.args.get('minCalories', default=200, type=int)
        max_calories = request.args.get('maxCalories', default=500, type=int)
        number = request.args.get('number', type=int)
        
        # API KEY 
        api_key = '597f65db5ee4465eb2691af5fa79484a'
        # Define the endpoint URL
        endpoint = 'https://api.spoonacular.com/recipes/complexSearch'
        # Define the query parameters
        params = {
            'query': query,
            'minCalories': min_calories,
            'maxCalories': max_calories,
            'number': number,
            'apiKey': api_key
        }
        
        # Make the GET request to the API
        response = requests.get(endpoint, params=params)
        
        # Check if the request was successful
        if response.status_code == 200:
            # Return the JSON response from the API
            return jsonify(response.json()), 200
        else:
            # Return an error message if the request was not successful
            return jsonify({"error": f"Failed to retrieve recipes. Status code: {response.status_code}"}), response.status_code
    except Exception as e:
        # Return an error message if an exception occurred
        return jsonify({"error": str(e)}), 400