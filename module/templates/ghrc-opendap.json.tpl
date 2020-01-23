[
  {
    "essential": true,
    "memory": 2048,
    "name": "${TASK_FAMILY_NAME}",
    "cpu": 1024,
    "image" : "${REPOSITORY_URL}",
    "networkMode": "awsvpc",
    "workingDirectory": "/",
    "command": [ "supervisord", "-c", "/etc/supervisord.conf" ],
    "environment": [{
      "name": "OPENDAP_BUCKET",
      "value": "${OPENDAP_BUCKET}"
    }],
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      },
      {
        "containerPort": 8080,
        "hostPort": 8080
      }
    ]
  }
]