resource "aws_iam_role_policy" "ecs_task_assume" {
  name   = "ecs_task_role_policy_assume"
  role   = aws_iam_role.ecs_task_assume.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
{
  "Effect": "Allow",
  "Action": [
    "ecr:GetAuthorizationToken",
    "ecr:BatchCheckLayerAvailability",
    "ecr:GetDownloadUrlForLayer",
    "ecr:BatchGetImage",
    "logs:CreateLogStream",
    "logs:PutLogEvents"
    ],
    "Resource":"*"
  },
  {
     "Effect": "Allow",
     "Action": [
       "s3:GetObject"
     ],
     "Resource": [
       "arn:aws:s3:::amarouane-opendap-data/*",
       "arn:aws:s3:::*/amarouane-opendap-data/*"
     ]
     }
  ]
}
EOF
}

resource "aws_iam_role" "ecs_task_assume" {
  name               = "ecs_task_role_assume"
  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
 "Statement": [
{
"Sid": "",
"Effect":"Allow",
"Principal": {
"Service": "ecs-tasks.amazonaws.com"
},
"Action":"sts:AssumeRole"
}
]
}
EOF
}

resource "aws_iam_role" "ecsTaskExcutionRoleGH" {
  name               = "ecsTaskExcutionRoleGHOpendap"
  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
 "Statement": [
{
"Sid": "",
"Effect":"Allow",
"Principal": {
"Service": "ecs-tasks.amazonaws.com"
},
"Action":"sts:AssumeRole"
}
]
}
EOF
}

resource "aws_iam_role_policy_attachment" "TaskExecutionPolicyAttachement" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecsTaskExcutionRoleGH.name
}