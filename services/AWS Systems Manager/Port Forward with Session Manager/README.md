# Port Forward with Session Manager
Replacing those pesky bastion hosts / Remote Desktop Gateways!

![PortForwardSSM](/images/PortForwardSSM.gif)

Traffic can be tunneled with SSM Session Manager service to securely connect and access EC2 infrastructure on AWS.
This requires barely no setup, no extra infrastructure to manage, and at no cost.
The solution also authenticates through IAM which means no SSH key management, and full audit trail through CloudTrail.

Once everything is setup, the SSMPortForward.sh script can be run from a local machine. Once the name of the instance is entered, the script will handle the rest.
Any port can be tunneled, including 3389(RDP) or 80(Web).

This feature can even be used on machines not connected to the internet using the [PrivateLink Endpoints](https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html).

## Prerequisites on local machine
- Bash/similar shell - Included on Linux/MacOS, Windows users can use [GitBash](https://git-scm.com/download/win).
- [jq](https://stedolan.github.io/jq/download/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-windows.html)
- [AWS CLI Session Manager plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html)
- [AWS CLI Configuration with named profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)

## Setup on EC2 Infrastructure through the Management Console
1. Create IAM EC2 Instance Profile by going to IAM -> Roles -> Create Role.
2. Select EC2 and go to Next.
3. Find AmazonSSMManagedInstanceCore AWS Managed Policy and attach it.
4. Optional: Enter Tags and click Review and then Create the role.
5. Go to EC2 Service.
6. Either create a new instance with the newly created EC2 role attached or,
Select existing instance and click Actions -> Instance Settings -> Attach/Replace IAM Role.
Make sure that the SSM agent is [included](https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-agent.html) during creation, otherwise, the agent will have to be installed with seperate tooling.
7. Done!

## Setup script
1. Change AWS_REGION if needed
2. Change AWS_ROLE_ARN to IAM role to assume in the same or another AWS account
3. Optional: Change LOCAL_PORT to the local port
4. Change REMOTE_PORT to the destination port on the machine. For RDP, leave 3389.
5. Change AWS_PROFILE_NAME to the AWS CLI named profile name.

## Run it
1. Run SSMPortForward.sh file ("./SSMPortForward.sh" from the same directory)
2. Enter the value of the Name-tag.
3. The script resolves the instance ID against the instance name-tag and initiates a SSM PortForward document.
4. The tunnel connection will be up until script is cancelled(CTRL+C) or connection is interupted in some way.