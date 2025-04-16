# #!/bin/bash
# yum update -y
# yum install -y python3 git
# pip3 install flask

# cd /home/ec2-user
# git clone https://github.com/nace129/careerpilot.git
# cd careerpilot/backend
# python3 app.py &

#!/bin/bash
sudo su
yum update -y
yum install -y python3 git

# Clone the repo
cd /home/ec2-user
git clone https://github.com/YOUR_USERNAME/careerpilot.git
cd careerpilot/backend

# Install Python dependencies
pip3 install -r requirements.txt --user

# Run Flask server in background
nohup python3 app.py > flask.log 2>&1 &

#Flask logs
tail -f flask.log -n 100
