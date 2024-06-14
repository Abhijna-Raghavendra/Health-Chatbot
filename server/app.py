from flask import Flask, render_template
from routes.chat import chat
from routes.signin import signin
from routes.signup import signup

app = Flask(__name__)

@app.route('/', methods=['GET'])
def index():
    return render_template('index.html')

@app.route('/signin', methods=['POST'])
def signin():
    return signin()

@app.route('/signup', methods=['POST'])
def signup():
    return signup()

@app.route('/chat', methods=['POST'])
def chat():
    return chat()

if __name__ == '__main__':
    app.run()
