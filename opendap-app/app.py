from flask import Flask, request
from requests import get
import boto3
from os import path, listdir
from pathlib import Path

import subprocess
app = Flask(__name__)
s3 = boto3.client('s3')


def return_time_left(bucket_name, s3_file_path, file_path, calibre_per_megabyte=4):
    """
    1 MG took 4 sec
    """
    response = s3.head_object(Bucket=bucket_name, Key=s3_file_path)
    real_size = float("{0:.2f}".format(response['ContentLength']/(1024*1024)))
    size_in_bytes = path.getsize(file_path)
    size_so_far = float("{0:.2f}".format(size_in_bytes/(1024*1024)))
    if real_size - size_so_far:
        time_left = float("{0:.2f}".format((real_size - size_so_far) * calibre_per_megabyte))
        return {'Status': 'Download in progress',
                'Time left': f"{time_left} seconds"}
    else:
        return {'Status': "Download Complete!", 'Info': f"Check {request.remote_addr}:8080/opendap/data/ghrc_data/{s3_file_path}.html"}


def use_boto3(sub_s3_file_path, bucket_name='amarouane-opendap-data'):
    file_name = path.basename(sub_s3_file_path)
    file_path = path.dirname(sub_s3_file_path)
    final_path = path.join('/usr/share/hyrax/data/ghrc_data', file_path)
    destination = path.join(final_path, file_name)
    Path(final_path).mkdir(parents=True, exist_ok=True)
    list_dir = listdir(final_path)
    for ele in list_dir:
        if file_name in ele:
            return return_time_left(bucket_name, sub_s3_file_path, path.join(final_path, ele))

    s3.download_file(bucket_name, sub_s3_file_path, destination)
    return return_time_left(bucket_name, sub_s3_file_path, destination)

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