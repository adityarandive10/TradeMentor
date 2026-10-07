import React from 'react';
import { Sparkles, ShieldCheck } from 'lucide-react';

const AIExplanation = ({ explanation }) => {
  return (
    <div className="bg-white rounded-xl border border-gray-200 shadow-sm flex flex-col p-6 relative overflow-hidden">
      <div className="flex items-center space-x-2 mb-4 text-blue-600">
        <Sparkles size={20} />
        <span className="font-semibold text-sm">AI Insight</span>
      </div>
      
      <p className="text-navy text-base leading-relaxed flex-1">
        {explanation || 'No explanation provided.'}
      </p>

      <div className="mt-6 flex items-center space-x-2 text-xs font-medium text-green-600 bg-green-50 w-fit px-3 py-1.5 rounded-full border border-green-100">
        <ShieldCheck size={14} />
        <span>Generated from the analyzed result set</span>
      </div>
    </div>
  );
};

export default AIExplanation;
