from flask import Blueprint, request, jsonify # type: ignore
from models.history import History
from app import db
from flask_jwt_extended import jwt_required, get_jwt_identity

history_bp = Blueprint('history', __name__)

@history_bp.route('/history', methods=['GET'])
@jwt_required()
def get_history():
    user_id = get_jwt_identity()
    history = History.query.filter_by(user_id=user_id).all()
    return jsonify([
        {"question": h.question, "response": h.response, "feedback": h.feedback, "timestamp": h.timestamp}
        for h in history
    ])
