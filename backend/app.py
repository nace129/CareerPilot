from flask import Flask
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_jwt_extended import JWTManager

app = Flask(__name__)
app.config['SECRET_KEY'] = 'super-secret-key'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///careerpilot.db'
app.config['JWT_SECRET_KEY'] = 'jwt-secret-string'

CORS(app)
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
jwt = JWTManager(app)

# Register blueprints
from routes.auth import auth_bp
from routes.interview import interview_bp
from routes.history import history_bp

app.register_blueprint(auth_bp, url_prefix='/auth')
app.register_blueprint(interview_bp)
app.register_blueprint(history_bp)

if __name__ == '__main__':
    db.create_all()
    # app.run(debug=True)
    app.run(host='0.0.0.0', port=5000)

@app.route('/')
def index():
    return {'message': 'CareerPilot Flask API is up and running!'}

@app.route('/generate-question')
def generate_question():
    return jsonify({
        "question": "Tell me about yourself.",
        "type": "behavioral"
    })