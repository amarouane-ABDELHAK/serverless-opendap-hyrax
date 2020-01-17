from flask import Flask, request
from requests import get

app = Flask(__name__)

@app.route("/")
def hello():
    file_path = request.args.get('path')
    print(file_path)

    re = get(f"http://localhost:8080/opendap/data/{file_path}.json")
    return re.content

if __name__ == "__main__":
    app.run(host='0.0.0.0')