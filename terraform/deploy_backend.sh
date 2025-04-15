#!/bin/bash
yum update -y
yum install -y python3 git
pip3 install flask

cd /home/ec2-user
git clone https://github.com/nace129/careerpilot.git
cd careerpilot/backend
python3 app.py &
