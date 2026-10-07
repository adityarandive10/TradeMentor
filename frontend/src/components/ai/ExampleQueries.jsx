import React from 'react';

const examples = [
  "Top 5 stocks by trading volume",
  "Highest portfolio value",
  "Pending buy orders",
  "Technology stocks"
];

const ExampleQueries = ({ onSelect }) => {
  return (
    <div className="flex flex-wrap items-center justify-center mt-6 gap-3">
      <span className="text-sm text-gray-400 mr-2">Try an example</span>
      {examples.map((ex, idx) => (
        <button
          key={idx}
          onClick={() => onSelect(ex)}
          className="text-sm text-gray-600 bg-white border border-gray-200 hover:border-gray-300 hover:bg-gray-50 px-4 py-2 rounded-full transition shadow-sm"
        >
          {ex}
        </button>
      ))}
    </div>
  );
};

export default ExampleQueries;
