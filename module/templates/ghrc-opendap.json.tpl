[
  {
    "essential": true,
    "memory": 256,
    "name": "${TASK_FAMILY_NAME}",
    "cpu": 256,
    "image" : "${REPOSITORY_URL}",
    "networkMode": "awsvpc",
    "workingDirectory": "/",
    "command": [ "supervisord", "-c", "/etc/supervisord.conf" ],
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