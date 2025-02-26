#!/bin/bash

read -p "Enter the server username: " REMOTE_USER
read -p "Enter the server IP-address: " REMOTE_HOST
read -p "Enter SSH key name: " SSH_KEY_NAME

echo "Generating SSH key pair..."
ssh-keygen -t rsa -b 4096 -f ~/.ssh/$SSH_KEY_NAME -N ""

echo "Copying public key to server..."
ssh-copy-id -i ~/.ssh/$SSH_KEY_NAME.pub $REMOTE_USER@$REMOTE_HOST

echo "Configuring SSH to use generated key..."
cat <<EOL >> ~/.ssh/config
Host $REMOTE_HOST
    HostName $REMOTE_HOST
    User $REMOTE_USER
    IdentityFile ~/.ssh/$SSH_KEY_NAME
EOL

echo "Testing connection..."
ssh $REMOTE_USER@$REMOTE_HOST "echo 'SSH connection successful!'"

echo "Setup complete. You can now SSH into $REMOTE_HOST using the key."
