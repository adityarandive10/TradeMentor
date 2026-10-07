import React, { useState } from 'react';
import { FileCode, Copy, Check } from 'lucide-react';

const SQLViewer = ({ sql }) => {
  const [copied, setCopied] = useState(false);

  const handleCopy = () => {
    navigator.clipboard.writeText(sql);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  const lines = sql ? sql.split('\n') : [];

  return (
    <div className="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm flex flex-col">
      <div className="flex items-center justify-between px-4 py-3 border-b border-gray-100 bg-gray-50/50">
        <div className="flex items-center space-x-3">
          <FileCode size={18} className="text-gray-400" />
          <span className="font-medium text-gray-700 text-sm">Generated SQL</span>
          <span className="text-[10px] font-semibold text-blue-600 bg-blue-50 border border-blue-100 px-2 py-0.5 rounded">PostgreSQL</span>
        </div>
        <button 
          onClick={handleCopy}
          className="flex items-center space-x-1 text-xs font-medium text-gray-500 hover:text-gray-700 transition"
        >
          {copied ? <Check size={14} className="text-green-500" /> : <Copy size={14} />}
          <span>{copied ? 'Copied!' : 'Copy'}</span>
        </button>
      </div>
      
      <div className="p-4 overflow-x-auto text-sm font-mono text-gray-700 bg-white leading-relaxed flex-1">
        {lines.map((line, i) => (
          <div key={i} className="flex">
            <span className="w-8 shrink-0 text-gray-300 select-none text-right pr-4">{i + 1}</span>
            <span className="whitespace-pre">{line}</span>
          </div>
        ))}
      </div>
    </div>
  );
};

export default SQLViewer;
