# Protected bastion host

### How to set up Protected Bastion host under Ubuntu Linux

#### 1. Launch the Bastion Host:

- Deploy a small Linux instance (e.g., Ubuntu, Amazon Linux) in a public subnet.
- Assign a public IP or Elastic IP.
- Install SSHD using "sudo apt update && sudo apt install -y openssh-server"
- Ensure SSH (port 22) is open only for trusted IPs in the security group. It is recommended to change port 22 to someting like 3421.

A Bastion Host (Jump Server) is a public-facing instance that allows access to private servers.

#### 2. Disable password authentication on the Bastion host:

sudo nano /etc/ssh/sshd_config:

```
PasswordAuthentication no
PermitRootLogin no
```

#### 3. Restart SSH service:

sudo systemctl restart ssh

#### 4. Add user without shell under Ubuntu Linux:

Bastion Host will not allow to have a shell for users. Launch bash script to add user under Linux without shell:

./add_user.sh