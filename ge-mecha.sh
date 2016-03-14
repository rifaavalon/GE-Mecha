#!/bin/bash


#Updates the package sources
sudo apt-get update

#Installs dependencies for git and other tools
sudo apt-get -y install build-essential git python-pip

sudo pip install awscli
#Changes to the /opt dir and gets the backup utils file
cd /opt

sudo git clone https://github.com/github/backup-utils.git

#Generates the SSH key needed for Admin on Github
sudo ssh-keygen -t rsa -C "github@example.com" -N "" -f ~/.ssh/id_rsa

#Run AWS Cli to start the instance output the instance id

instance_id=$(aws ec2 run-instances --image-id ami-7c25021f --instance-type r3.xlarge --security-group-id XXX --subnet-id XXXX --block-device-mappings '[{"DeviceName":"/dev/xvdf","Ebs":{"VolumeSize":250,"VolumeType":"gp2"}}]' --region XXXX --ebs-optimized --output text --query 'Instances[*].InstanceId')

    echo instance_id=$instance_id
#Wait for the instance to come alive and output the state of the instance
    while state=$(aws ec2 describe-instances --region XXXXX --instance-ids $instance_id --output text --query 'Reservations[*].Instances[*].State.Name'); test "$state" = "pending"; do
  sleep 5m; echo -n '.'
done;
echo " $state"


#Get the instance ip address
ip_address=$(aws ec2 describe-instances --region XXXX --instance-ids $instance_id --output text --query 'Reservations[*].Instances[*].PrivateIpAddress')
echo ip_address=$ip_address
curl

curl -L -X POST 'https://$ip_address:8443/setup/api/start' -F license=@/path/to/enterpriselicense -F "password=/path/to/settings.json" -F settings=<settings.json
