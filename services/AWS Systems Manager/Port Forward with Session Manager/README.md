# Port Forward with Session Manager
Replacing those pesky bastion hosts / Remote Desktop Gateways!

Traffic can be tunneled with SSM Session Manager service to securely connect and access EC2 infrastructure on AWS.
This requires barely no setup, no extra infrastructure to manage, and at no cost.
The solution also authenticates through IAM which means no SSH key management, and full audit trail through CloudTrail.

Any port can be tunneled, including 3389(RDP) or 80(Web).

## Prerequisites on local machine
- Bash/similar shell - Included on Linux/MacOS, Windows users can use [GitBash](https://git-scm.com/download/win).
- [jq](https://stedolan.github.io/jq/download/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-windows.html)
- [AWS CLI Session Manager plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html)
- [AWS CLI Configuration with named profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)

## Setup on EC2 Infrastructure *Management Console*
1. Create IAM EC2 Instance Profile by going to IAM -> Roles -> Create Role.
2. Select EC2 and go to Next.
3. Find AmazonSSMManagedInstanceCore AWS Managed Policy and attach it.
4. Optional: Enter Tags and click Review and then Create the role.
5. Go to EC2 Service.
6. Either create a new instance with the newly created EC2 role attached or,
Select existing instance and click Actions -> Instance Settings -> Attach/Replace IAM Role.
Make sure that the SSM agent is [included](https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-agent.html) during creation, otherwise, the agent will have to be installed with seperate tooling.
7. 