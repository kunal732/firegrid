rom flask import Flask, request
import json, requests
from firebase import firebase

app = Flask(__name__)

firebase = firebase.FirebaseApplication('Your_Firebase_url_goes_here', None)
@app.route('/',methods=['POST'])
def foo():
   json2 = request.json
   data = {}
   for event in json2:
      for key, val in event.iteritems():
         data[key] = val
      r = requests.post('Your_Firebase_url_goes_here',json.dumps(data))
      data = {}
   return "OK"
   
if __name__ == '__main__':
   app.run(debug=True)