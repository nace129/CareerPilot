from flask import Blueprint, request, jsonify

interview_bp = Blueprint('interview', __name__)

@interview_bp.route('/generate-question', methods=['GET'])
def generate_question():
    return jsonify(question="What are your strengths?")

@interview_bp.route('/analyze-response', methods=['POST'])
def analyze_response():
    data = request.get_json()
    response = data.get("response", "")
    # Simulated feedback
    feedback = "Try to give more specific examples."
    return jsonify(feedback=feedback)
