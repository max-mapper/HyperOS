#!/bin/sh
# put other system startup commands here

# sanity check
sudo chown -R tc /home/tc
sudo chown root /var/lib/sshd

# for ssh login (will generate local keypairs on first run automaticalliy)
sudo /usr/local/etc/init.d/openssh start

# setup authorized_keys
sudo /etc/init.d/set-ssh-auth-key
