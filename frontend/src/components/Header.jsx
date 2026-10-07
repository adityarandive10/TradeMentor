import React, { useState, useEffect } from 'react';
import { Settings, User, Activity } from 'lucide-react';

const Header = () => {
  const [dbConnected, setDbConnected] = useState(true); // Assuming true for now

  useEffect(() => {
    // Check health endpoint
    fetch('/api/health/db')
      .then(res => res.json())
      .then(data => {
        setDbConnected(data.status === 'UP');
      })
      .catch(() => setDbConnected(false));
  }, []);

  return (
    <header className="bg-white border-b border-border-gray px-8 py-4 flex items-center justify-between">
      <div className="flex items-center space-x-8">
        <div className="flex items-center space-x-2">
          <div className="bg-navy text-white p-1 rounded">
            <Activity size={24} />
          </div>
          <span className="text-xl font-bold text-navy">TradeSphere</span>
          <span className="text-xs font-semibold text-primary bg-blue-50 border border-blue-100 px-2 py-0.5 rounded-full">PRO</span>
        </div>
        <nav className="flex space-x-6 text-sm font-medium text-gray-500">
          <a href="#" className="hover:text-navy">Portfolio</a>
          <a href="#" className="hover:text-navy">Markets</a>
          <a href="#" className="text-navy bg-gray-50 border border-gray-200 px-3 py-1.5 rounded-md">AI Analyst</a>
        </nav>
      </div>
      
      <div className="flex items-center space-x-6 text-sm">
        <div className="flex items-center space-x-2">
          <div className={`w-2 h-2 rounded-full ${dbConnected ? 'bg-green-500' : 'bg-red-500'}`}></div>
          <span className="text-gray-600">{dbConnected ? 'Database Connected' : 'Database Disconnected'}</span>
        </div>
        <div className="flex items-center space-x-4 text-gray-500">
          <Settings size={20} className="cursor-pointer hover:text-navy" />
          <div className="w-8 h-8 rounded-full border border-gray-200 flex items-center justify-center cursor-pointer hover:bg-gray-50">
            <User size={18} />
          </div>
        </div>
      </div>
    </header>
  );
};

export default Header;
