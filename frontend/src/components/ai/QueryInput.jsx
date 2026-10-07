import React from 'react';
import { Play } from 'lucide-react';

const QueryInput = ({ question, setQuestion, onAnalyze, loading }) => {
  return (
    <div className="bg-white rounded-2xl shadow-sm border border-border-gray p-4">
      <div className="flex items-start mb-4">
        <span className="text-primary mt-1 mr-3">*</span>
        <textarea
          value={question}
          onChange={(e) => setQuestion(e.target.value)}
          placeholder="Ask a question about your portfolio..."
          className="w-full text-lg text-navy placeholder-gray-400 focus:outline-none resize-none"
          rows={3}
          disabled={loading}
          onKeyDown={(e) => {
            if (e.key === 'Enter' && !e.shiftKey) {
              e.preventDefault();
              onAnalyze();
            }
          }}
        />
      </div>
      <div className="flex items-center justify-between border-t border-gray-100 pt-3">
        <div className="flex items-center space-x-2 text-xs text-gray-400 font-medium">
          <span className="bg-gray-100 px-1.5 py-0.5 rounded border border-gray-200">⌘</span>
          <span className="bg-gray-100 px-1.5 py-0.5 rounded border border-gray-200">↵</span>
          <span>to analyze</span>
        </div>
        <button
          onClick={onAnalyze}
          disabled={loading || !question.trim()}
          className="flex items-center space-x-2 bg-primary hover:bg-primary-dark text-white px-5 py-2 rounded-lg font-medium transition disabled:opacity-50"
        >
          <Play size={16} fill="currentColor" />
          <span>Analyze</span>
        </button>
      </div>
    </div>
  );
};

export default QueryInput;
