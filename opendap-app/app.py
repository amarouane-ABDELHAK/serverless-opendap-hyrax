from flask import Flask, request
from requests import get
import boto3
from os import path

import subprocess
app = Flask(__name__)



def use_boto3(file_name):
    s3 = boto3.client('s3')
    file_path = path.dirname(file_name)
    run_command(f"mkdir -p {file_path}")
    final_path = path.join('/usr/share/hyrax/data/ghrc_data', file_name)
    return s3.download_file('amarouane-opendap-data', file_name, final_path)

def run_command(cmd):
    """
    Run cmd as a system command
    """
    return subprocess.check_output(cmd.split(' '), stderr=subprocess.STDOUT)
    # try:
    #     out = subprocess.check_output(cmd.split(' '), stderr=subprocess.STDOUT)
    #     return out
    # except Exception as e:
    #     raise RuntimeError('Error running %s' % str(e))


@app.route("/")
def hello():
    file_path = request.args.get('path')
    print(file_path)

    re = get(f"http://localhost:8080/opendap/data/{file_path}.json")
    return re.content


@app.route("/get")
def getfile():
    file_path = request.args.get('s3path')
    get_file_cmd = f"aws s3 cp {file_path} /usr/share/hyrax/data/."
    #get_file_cmd = f"aws s3 cp {file_path} /usr/share/hyrax/data/."
    try:
        #run_command(get_file_cmd)
        res = use_boto3(file_path)
        return {'Success': res}
    except Exception as e:
        return {'Error': str(e)}


if __name__ == "__main__":
    app.run(host='0.0.0.0')