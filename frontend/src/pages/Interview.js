import QuestionViewer from '../components/QuestionViewer';
import FeedbackDisplay from '../components/FeedbackDisplay';
import VoiceInput from '../components/VoiceInput';

const Interview = () => (
  <div>
    <h2>Interview Simulator</h2>
    <QuestionViewer />
    <VoiceInput />
    <FeedbackDisplay />
  </div>
);
export default Interview;
