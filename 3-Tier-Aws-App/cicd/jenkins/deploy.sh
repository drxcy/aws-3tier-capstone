#!/bin/bash
set -e  # Exit on error

APP_DIR="/home/ec2-user/aws-3tier-capstone/3-Tier-Aws-App/app"

echo "[INFO] 🚀 Starting Node.js deployment..."

# Ensure app directory exists
ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST "mkdir -p $APP_DIR"

# Copy project files from Jenkins workspace to EC2
scp -o StrictHostKeyChecking=no -r * $EC2_USER@$EC2_HOST:$APP_DIR/

# Run commands on EC2
ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST << 'EOF'
  cd /home/ubuntu/app

  echo "[INFO] 📦 Installing dependencies..."
  npm install

  echo "[INFO] 🛠️ Building app (if build script exists)..."
  if npm run | grep -q "build"; then
    npm run build
  fi

  echo "[INFO] 🔄 Restarting Node.js app with PM2..."
  if command -v pm2 >/dev/null 2>&1; then
    pm2 restart app || pm2 start app.js --name app
  else
    echo "[INFO] Installing PM2..."
    npm install -g pm2
    pm2 start app.js --name app
  fi

  echo "[INFO] ✅ Deployment successful!"
EOF
