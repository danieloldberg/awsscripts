unset  AWS_ACCESS_KEY_ID
unset  AWS_SECRET_ACCESS_KEY
unset  AWS_SESSION_TOKEN
export AWS_REGION="eu-north-1"
export AWS_ROLE_ARN="arn:aws:iam::ACCOUNTID:role/ROLENAME"
export LOCAL_PORT="56789" #LOCALHOST RDP PORT
export REMOTE_PORT="3389" #RDP
export AWS_PROFILE_NAME = ""
#SET INSTANCE NAME
echo "Instance name-tag?"
read machinename
export INSTANCE_NAME=$machinename

# IF no Profile
#temp_role=$(aws sts assume-role \
#                    --role-arn $AWS_ROLE_ARN \
#                    --role-session-name "session-manager-port-forward")

# IF Profile
temp_role=$(aws sts assume-role \
                    --role-arn $AWS_ROLE_ARN \
                    --role-session-name "session-manager-port-forward" --profile $AWS_PROFILE_NAME)

export AWS_ACCESS_KEY_ID=$(echo $temp_role | jq -r .Credentials.AccessKeyId)
export AWS_SECRET_ACCESS_KEY=$(echo $temp_role | jq -r .Credentials.SecretAccessKey)
export AWS_SESSION_TOKEN=$(echo $temp_role | jq -r .Credentials.SessionToken)

instance_id=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$INSTANCE_NAME" \
    --query "Reservations[*].Instances[*].[InstanceId]" --output text)

aws ssm start-session --target $instance_id --document-name AWS-StartPortForwardingSession --parameters '{"portNumber":["'${REMOTE_PORT}'"], "localPortNumber":["'${LOCAL_PORT}'"]}' --region $AWS_REGION

unset  AWS_ACCESS_KEY_ID
unset  AWS_SECRET_ACCESS_KEY
unset  AWS_SESSION_TOKEN