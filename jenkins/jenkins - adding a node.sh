#!/bin/bash


### [ VIA SSH ON NEW NODE ] Create the jenkins_ssh user on the new node as a sudoer (add to "sudo" usergroup & create "/etc/sudoers.d/jenkins_ssh" correctly)
#>  /usr/local/sbin/add_user



### [ VIA SSH ON NEW NODE ] Create an SSH-Key on the new Node & copy the public-key to "/etc/ssh/authorized_keys/jenkins_ssh";
#>  /usr/local/sbin/ssh_keygen
#>  sudo chmod 0400 "/etc/ssh/authorized_keys/jenkins_ssh";
#>  sudo chown "jenkins_ssh:jenkins_ssh" "/etc/ssh/authorized_keys/jenkins_ssh";



### [ VIA BROWSER ON JENKINS ]
###    Create a new credential via https://[JENKINS_URL]/credentials
###      |--> kind='SSH username with private key'
###      |--> Scope='System' - Paste Private key into it & Save
###      |--> Key -> (press "Add button) -> paste newly-created SSH Private-key here



### [ VIA SSH ON JENKINS LINUX BOX ] Read-in the node's ssh host-keys from new node's IPv4 (example uses 1.2.3.4) into Jenkins' known_hosts file
#>  sudo ssh-keyscan -H "1.2.3.4" >> "$(getent passwd jenkins | cut --delimiter=: --fields=6)/.ssh/known_hosts";



### [ VIA SSH ON NEW NODE ] Install Docker
#>  ## NEED STEPS TO INSTALL DOCKER, HERE ##



### [ VIA SSH ON NEW NODE ] Install Java
#>  sudo apt-get update -y && sudo apt-get install -y default-jdk-headless default-jre-headless && sudo apt-get -y autoremove && sudo apt-get -y clean;



### [ VIA SSH ON NEW NODE ] Update boneal user to have UID=500 & GID=500
#>  sudo usermod --uid "500" "boneal"; sudo groupmod --gid "500" "boneal";



### [ VIA SSH ON NEW NODE ] CLEANUP --> lots of files were left-over with GID 1000 even though they should've been updated to 500
#>  ### chown -R "boneal:boneal" "/home/boneal/public_html/";
#>  ### find "/" -gid "1000" -exec chgrp --changes "500" '{}' \;






