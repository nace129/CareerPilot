from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_cors import CORS
from flask_jwt_extended import JWTManager

db = SQLAlchemy()
bcrypt = Bcrypt()
jwt = JWTManager()

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'super-secret-key'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///careerpilot.db'
    app.config['JWT_SECRET_KEY'] = 'jwt-secret-key'

    db.init_app(app)
    bcrypt.init_app(app)
    jwt.init_app(app)
    CORS(app)

    from routes.auth import auth_bp
    from routes.interview import interview_bp
    from routes.history import history_bp

    app.register_blueprint(auth_bp, url_prefix="/auth")
    app.register_blueprint(interview_bp)
    app.register_blueprint(history_bp)

    return app
