from app.main import bp
from flask import Flask, request, jsonify
import pyrebase


config = {
  'apiKey': "AIzaSyAgTCgwmHagAMa59FfdSnKAwchZg51OQCw",
  'authDomain' : "cs125-project-b6ea5.firebaseapp.com",
  'projectId' : "cs125-project-b6ea5",
  'storageBucket' : "cs125-project-b6ea5.appspot.com",
  'messagingSenderId' : "63446463144",
  'appId' : "1:63446463144:web:5f3d8e158538109690489d",
  'measurementId': "G-YKGZ6Q2317",
   'databaseURL': '',
}

firebase = pyrebase.initialize_app(config)
auth = firebase.auth()

@bp.route('/', methods=['GET'])
def index():
    return 'Hello'

@bp.route('/login', methods=['POST'])
def login():
    try:
        email = request.json['email']
        password = request.json['password']
        user = auth.sign_in_with_email_and_password(email, password)
        return jsonify({"message": "Login successful", "idToken": user['idToken']}), 200
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

