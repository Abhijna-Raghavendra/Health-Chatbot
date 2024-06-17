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
    contact = data.get('emergency-contact')
    chronic_conditions = data.get('chronic-conditions')
    medications = data.get('medications')
    surgeries = data.get('surgeries')
    allergies = data.get('allergies')
    family_history = data.get('family-history')
    smoking = data.get('smoking')
    alcohol = data.get('alcohol')
    emergency_contact = data.get('emergency-contact')   

    hashed_password = generate_password_hash(password)

    user_data = {
        'username': username,
        'password': hashed_password,  
        'name': name,
        'dob': dob,
        'gender': gender,
        'emergency_contact': contact,
        'chronic_conditions': chronic_conditions,
        'medications': medications,
        'surgeries': surgeries,
        'allergies': allergies,
        'family_history': family_history,
        'smoking': smoking,
        'alcohol': alcohol,
        'emergency_contact': emergency_contact
    }

    db.users.insert_one(user_data)

    return jsonify({'message': 'Signup successful'}), 200
