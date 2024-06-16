from flask import jsonify, request
import PyMongo
from werkzeug.security import check_password_hash
import os
mongodb_uri = os.environ['MONGODB_URI']

mongo = PyMongo()

def signin():
    data = request.json  
    username = data.get('username')
    password = data.get('password')

    user_data = mongo.db.users.find_one({'username': username})

    if user_data and check_password_hash(user_data['password'], password):
        response = {
            'message': 'Login successful',
            'username': user_data['username'],  
            'name': user_data.get('name', ''),
            'dob': user_data.get('dob', ''),
            'gender': user_data.get('gender', ''),
            'chronic_conditions' : user_data.get('chronic-conditions',''),
            'medications' : user_data.get('medications',''),
            'surgeries' : user_data.get('surgeries',''),
            'allergies':user_data.get('allergies'),
            'family_history' : user_data.get('family-history',''),
            'smoking' :user_data.get('smoking',''),
            'alcohol' : user_data.get('alcohol',''),


        }
        return jsonify(response), 200
    else:
        return jsonify({'message': 'Invalid username or password'}), 401
