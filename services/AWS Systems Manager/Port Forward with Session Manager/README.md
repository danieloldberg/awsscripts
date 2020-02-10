# Port Forward with Session Manager
Replacing those pesky bastion hosts / Remote Desktop Gateways!

Traffic can be tunneled with SSM Session Manager service to securely connect and access EC2 infrastructure on AWS.
This requires barely no setup, no extra infrastructure to manage, and at no cost.

## Prerequisites on local machine
- Bash/similar shell - Included on Linux/MacOS, Windows users can use [GitBash](https://git-scm.com/download/win).
- [jq](https://stedolan.github.io/jq/download/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-windows.html)
- [AWS CLI Session Manager plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html)
- [AWS CLI Configuration with named profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)

