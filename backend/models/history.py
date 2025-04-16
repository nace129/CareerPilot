from app import db
from datetime import datetime
from backend import db


class History(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer)
    question = db.Column(db.String(500))
    response = db.Column(db.String(1000))
    feedback = db.Column(db.String(1000))
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)
