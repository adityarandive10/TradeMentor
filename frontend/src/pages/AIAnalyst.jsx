import React, { useState } from 'react';
import QueryInput from '../components/ai/QueryInput';
import ExampleQueries from '../components/ai/ExampleQueries';
import QueryStatus from '../components/ai/QueryStatus';
import SQLViewer from '../components/ai/SQLViewer';
import AIExplanation from '../components/ai/AIExplanation';
import QueryResults from '../components/ai/QueryResults';

const AIAnalyst = () => {
  const [question, setQuestion] = useState('');
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState(null);
  const [error, setError] = useState(null);

  const handleAnalyze = async (queryText) => {
    if (!queryText.trim()) return;
    
    setQuestion(queryText);
    setLoading(true);
    setError(null);
    setResult(null);

    try {
      const response = await fetch('/api/ai/analyze', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ question: queryText }),
      });

      const data = await response.json();

      if (response.ok && data.success) {
        setResult(data);
      } else {
        setError(data.error || 'Failed to analyze query.');
      }
    } catch (err) {
      setError(err.message || 'Network error.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex flex-col items-center w-full max-w-5xl mx-auto space-y-8">
      {/* Hero Section */}
      <div className="text-center space-y-4 mt-8">
        <div className="inline-flex items-center space-x-2 bg-blue-50 text-blue-700 px-4 py-1.5 rounded-full text-xs font-semibold tracking-wide border border-blue-100 uppercase">
          <span className="text-lg leading-none mt-[-2px]">*</span>
          <span>AI-POWERED DATABASE ANALYSIS</span>
        </div>
        <h1 className="text-5xl font-extrabold text-navy tracking-tight">Ask your trading data anything.</h1>
        <p className="text-gray-500 text-lg">Turn natural-language questions into secure SQL queries and actionable insights.</p>
      </div>

      <div className="w-full max-w-3xl relative mt-4">
        <QueryInput 
          question={question} 
          setQuestion={setQuestion} 
          onAnalyze={() => handleAnalyze(question)}
          loading={loading}
        />
        <ExampleQueries onSelect={(q) => handleAnalyze(q)} />
      </div>

      {loading && (
        <div className="w-full mt-12 p-8 text-center space-y-4 text-gray-500">
          <div className="animate-pulse space-y-2">
            <div>Understanding question...</div>
            <div>Generating SQL...</div>
            <div>Validating query...</div>
            <div>Analyzing results...</div>
          </div>
        </div>
      )}

      {error && (
        <div className="w-full mt-12 bg-white border border-red-200 rounded-xl p-6 shadow-sm">
          <h3 className="text-lg font-semibold text-red-600 mb-2">Unable to analyze query</h3>
          <p className="text-gray-700 mb-4">{error}</p>
          <button 
            onClick={() => handleAnalyze(question)}
            className="px-4 py-2 bg-red-50 text-red-600 rounded-md font-medium hover:bg-red-100 transition"
          >
            Try again
          </button>
        </div>
      )}

      {result && !loading && (
        <div className="w-full mt-8 space-y-6">
          <QueryStatus result={result} />
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <SQLViewer sql={result.sql} />
            <AIExplanation explanation={result.explanation} />
          </div>

          <QueryResults results={result.results} />
        </div>
      )}

      {!result && !loading && !error && (
        <div className="w-full mt-16 text-center text-gray-400">
          <p className="text-xl font-medium text-gray-500">Your trading data, conversational.</p>
          <p className="mt-2">Ask a question and TradeSphere will generate, validate and analyze the SQL for you.</p>
        </div>
      )}
    </div>
  );
};

export default AIAnalyst;
