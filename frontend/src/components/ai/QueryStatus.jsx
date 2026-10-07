import React from 'react';
import { CheckCircle2, Clock } from 'lucide-react';

const QueryStatus = ({ result }) => {
  return (
    <div className="flex items-center justify-between w-full pb-2">
      <div className="flex items-center space-x-2 text-green-600 font-medium">
        <CheckCircle2 size={20} />
        <span>Analysis complete</span>
      </div>
      
      <div className="flex items-center space-x-3 text-xs text-gray-500 font-medium">
        {result.readOnly && (
          <div className="bg-white border border-gray-200 px-3 py-1.5 rounded-full shadow-sm">
            Read-only
          </div>
        )}
        {result.executionTimeMs !== undefined && (
          <div className="flex items-center space-x-1 bg-white border border-gray-200 px-3 py-1.5 rounded-full shadow-sm">
            <Clock size={14} />
            <span>{result.executionTimeMs} ms</span>
          </div>
        )}
        {result.rowCount !== undefined && (
          <div className="bg-white border border-gray-200 px-3 py-1.5 rounded-full shadow-sm">
            {result.rowCount} result{result.rowCount !== 1 ? 's' : ''}
          </div>
        )}
      </div>
    </div>
  );
};

export default QueryStatus;
