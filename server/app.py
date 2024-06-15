from flask import Flask, render_template, request
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
    # data = request.form
    # m = data.to_dict()['message']
    # response = chat(m)
    response  = 'i work'
    return response

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
