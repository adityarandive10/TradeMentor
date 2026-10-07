import React from 'react';

const formatValue = (val, colName) => {
  if (val === null || val === undefined) return <span className="text-gray-400 italic">null</span>;
  
  if (typeof val === 'number') {
    // Basic currency detection based on column name
    const lowerCol = colName.toLowerCase();
    if (lowerCol.includes('price') || lowerCol.includes('value') || lowerCol.includes('balance') || lowerCol.includes('amount')) {
      return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(val);
    }
    return new Intl.NumberFormat('en-US').format(val);
  }
  
  return String(val);
};

const QueryResults = ({ results }) => {
  if (!results || results.length === 0) {
    return (
      <div className="bg-white rounded-xl border border-gray-200 p-8 text-center text-gray-500 shadow-sm mt-6">
        No results found for this query.
      </div>
    );
  }

  const columns = Object.keys(results[0]);

  return (
    <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden mt-6">
      <div className="px-6 py-4 border-b border-gray-100 bg-gray-50/30">
        <h3 className="text-base font-semibold text-navy">Query Results</h3>
        <p className="text-xs text-gray-500 mt-1">Live data returned by your read-only query</p>
      </div>
      
      <div className="overflow-x-auto">
        <table className="w-full text-sm text-left">
          <thead className="text-xs text-gray-400 uppercase bg-gray-50/50 border-b border-gray-100">
            <tr>
              {columns.map(col => (
                <th key={col} className={`px-6 py-3 font-semibold ${typeof results[0][col] === 'number' ? 'text-right' : ''}`}>
                  {col.replace(/_/g, ' ')}
                </th>
              ))}
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-100">
            {results.map((row, idx) => (
              <tr key={idx} className="hover:bg-gray-50/50 transition">
                {columns.map(col => (
                  <td key={col} className={`px-6 py-4 text-navy ${typeof row[col] === 'number' ? 'text-right font-medium' : ''}`}>
                    {formatValue(row[col], col)}
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default QueryResults;
