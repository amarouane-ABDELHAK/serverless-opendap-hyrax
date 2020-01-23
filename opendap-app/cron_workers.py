import schedule
import subprocess
import time
from os import environ

def run_command(cmd):
    """ Run cmd as a system command """
    try:
        out = subprocess.check_output(cmd.split(' '), stderr=subprocess.STDOUT)
        return out
    except Exception as e:
        raise RuntimeError('Error %s running %s' % (cmd, str(e)))


def sync_s3(bucket_name='amarouane-opendap-data'):
    bucket_name = environ.get('OPENDAP_BUCKET', bucket_name)
    cmd = f"bash /root/sync_files.sh {bucket_name}"
    run_command(cmd)


# TODO make the bucket as env variable for the activity

schedule.every(2).minutes.do(sync_s3)

while True:
    schedule.run_pending()
    time.sleep(1)
