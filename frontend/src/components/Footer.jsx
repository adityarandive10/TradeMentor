import React from 'react';
import { ShieldCheck } from 'lucide-react';

const Footer = () => {
  return (
    <footer className="w-full max-w-6xl mx-auto px-4 py-6 mt-auto">
      <div className="flex items-center justify-between text-xs text-gray-400">
        <span>TradeSphere AI Analyst</span>
        <div className="flex items-center space-x-1.5 text-green-600">
          <ShieldCheck size={14} />
          <span>Secure read-only analysis</span>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
