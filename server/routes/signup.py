from flask import request, jsonify
from pymongo import MongoClient
from werkzeug.security import generate_password_hash
import os

mongodb_uri = os.environ['MONGO_URI']
client = MongoClient(mongodb_uri)
db = client["rockingpenny4"]

def signup():
    data = request.json  
    username = data.get('username')
    password = data.get('pswd') 
    name = data.get('name')
    dob = data.get('dob')
    gender = data.get('gender')
    chronic_conditions = data.get('chronic-conditions')
    medications = data.get('medications')
    surgeries = data.get('surgeries')
    allergies = data.get('allergies')
    family_history = data.get('family-history')
    smoking = data.get('smoking')
    alcohol = data.get('alcohol')

    hashed_password = generate_password_hash(password)

    user_data = {
        'username': username,
        'password': hashed_password,  
        'name': name,
        'dob': dob,
        'gender': gender,
        'chronic_conditions': chronic_conditions,
        'medications': medications,
        'surgeries': surgeries,
        'allergies': allergies,
        'family_history': family_history,
        'smoking': smoking,
        'alcohol': alcohol
    }

    db.users.insert_one(user_data)

    return jsonify({'message': 'Signup successful'}), 200
