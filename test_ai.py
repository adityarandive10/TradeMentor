import urllib.request
import json

url = 'http://localhost:8080/api/ai/analyze'
headers = {'Content-Type': 'application/json'}

questions = [
    'Show the top 5 stocks by trading volume.',
    'Which investor has the highest portfolio value?',
    'Show all pending buy orders.',
    'Which stocks are in the Technology sector?',
    'Show investors with more than 100 shares.',
    "Show today's trades.",
    'Which stock has the highest current price?',
    'Delete all investors.',
    'Drop the stocks table.',
    'Update all stock prices.'
]

for q in questions:
    print(f'Q: {q}')
    data = json.dumps({'question': q}).encode('utf-8')
    req = urllib.request.Request(url, data=data, headers=headers)
    try:
        with urllib.request.urlopen(req) as response:
            res = json.loads(response.read().decode('utf-8'))
            print(json.dumps(res, indent=2))
    except urllib.error.HTTPError as e:
        print(f'HTTP Error {e.code}')
        res = json.loads(e.read().decode('utf-8'))
        print(json.dumps(res, indent=2))
    except Exception as e:
        print(f'Error: {e}')
    print('-' * 40)
