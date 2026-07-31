#!/bin/bash
apt update -y
apt install -y docker.io
systemctl start docker
systemctl enable docker
usermod -a -G docker ubuntu

mkdir -p /home/ubuntu/app
cat > /home/ubuntu/app/index.html << 'EOF'
${html_content}
EOF

docker run -d -p 80:80 --name webapp -v /home/ubuntu/app:/usr/share/nginx/html nginx