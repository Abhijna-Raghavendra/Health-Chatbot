from flask import Flask, render_template, request
from routes.chat import chat_response
from routes.signin import signin_response
from routes.signup import signup_response

app = Flask(__name__)

@app.route('/', methods=['GET'])
def index():
    return render_template('index.html')

@app.route('/signin', methods=['POST'])
def signin():
    data = request.json
    response = signin_response(data)
    return response

@app.route('/signup', methods=['POST'])
def signup():
    data = request.json
    response = signup_response(data)
    return response

@app.route('/chat', methods=['POST'])
def chat():
    data = request.json
    response = chat_response(data['message'])
    return m

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
