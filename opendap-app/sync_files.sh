unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
aws s3 sync s3://$1 /usr/share/hyrax/data/ghrc_data/.

exit 0
